# NoBacksies is a layer over Ruby's callback methods, such as
# `method_added` and `inherited`. A class or module that includes it adds
# to a callback with a block, any number of times, without redefining the
# method.
#
#     class Y
#       include NoBacksies
#
#       def self.list
#         @list ||= []
#       end
#
#       callback :method_added do |method|
#         list << method
#       end
#
#       def foo; end
#       def bar; end
#     end
#
#     Y.list  #=> [:foo, :bar]
#
# The callbacks are those of a class or module: `method_added`,
# `method_removed`, `method_undefined`, `singleton_method_added`,
# `singleton_method_removed`, `singleton_method_undefined`,
# `const_missing`, `included`, `extended` and `inherited`. Including
# `NoBacksies` (or `NoBacksies::Callbacks`, its name in the gem) sets up
# all ten. To set up one alone, include its module, such as
# `NoBacksies::MethodAdded`.
#
# A subclass has its superclass's callbacks as well as its own.
#
# == Options
#
# With `:once`, a callback is used one time and then removed. That makes
# a method which applies to the next method defined:
#
#     class Y
#       include NoBacksies
#
#       def self.doc(string)
#         callback :method_added, :once=>true do |method|
#           docs[method] = string
#         end
#       end
#     end
#
# A callback that itself does what it is called for, such as a
# `method_added` callback that defines a method, would call itself without
# end. With `:safe`, the callbacks of that name are switched off while it
# runs:
#
#     callback :method_added, :safe=>true do |method|
#       define_method("#{method}!") do
#         send(method) + "!"
#       end
#     end
#
# `callback_express` does the same by hand, for the length of a block or
# from then on:
#
#     callback_express(:method_added=>false) do
#       define_method(:quiet){ }
#     end
#
# == Calling super
#
# After the callbacks have run, Ruby's own method is called with `super`,
# once. When no callback is defined, or the callbacks are switched off,
# `super` is all that is called. A callback is also given a block that
# calls `super`. To call it at a time of your choosing, or not at all,
# give `:superless`, which stops it being called afterwards:
#
#     callback :included, :superless=>true do |mod, &superblock|
#       superblock.call
#       ...
#     end
#
# `const_missing` is the exception: its `super` raises NameError, so it
# is left for the callback to call, and the constant's value is what the
# last callback returns:
#
#     callback :const_missing do |const, &superblock|
#       pseudo_constants[const] || superblock.call
#     end
#
# NoBacksies was part of the gem of the same name.

module NoBacksies

  # The callback methods of a class or module that are supported.
  CALLBACKS = [
    :method_added, :method_removed, :method_undefined,
    :singleton_method_added, :singleton_method_removed,
    :singleton_method_undefined,
    :const_missing, :included, :extended, :inherited
  ]

  # Set up all the callbacks.
  def self.append_features(base)
    base.extend CallbackMethods
    CALLBACKS.each do |name|
      base.extend const_get(module_name(name))
    end
  end

  # The name of a callback's module: `:method_added` gives `:MethodAdded`.
  def self.module_name(name)
    name.to_s.split('_').map{ |part| part.capitalize }.join.to_sym
  end

  # The same as including NoBacksies itself. This is the module that was
  # included when NoBacksies was a gem.
  module Callbacks
    def self.append_features(base)
      NoBacksies.append_features(base)
    end
  end

  # The methods that define and run callbacks. They are added along with
  # any of the callback modules.
  module CallbackMethods

    # Define a callback.
    #
    # name    - The name of a callback method, such as `:method_added`.
    # options - :once to use it one time, :safe to switch the callbacks
    #           of this name off while it runs, :superless to leave out
    #           the call to super that follows.
    #
    # The block is given the callback method's arguments, and a block
    # that calls super.
    def callback(name, options={}, &block)
      raise ArgumentError, "no block given" unless block
      callbacks[name.to_sym] << [block, options]
      self
    end

    # The callbacks defined here, as a Hash of name to a list of block
    # and options. Those of a superclass are not among them.
    def callbacks
      @_callbacks ||= Hash.new{ |h,k| h[k] = [] }
    end

    # Switch callbacks on and off: `callback_express(:included=>false)`.
    # With a block, the change lasts until the block returns.
    #
    # Returns a Hash of name to true or false.
    def callback_express(express={})
      @_callback_express ||= Hash.new{ |h,k| h[k] = true }

      if block_given?
        saved = @_callback_express.dup
        begin
          express.each{ |k,v| @_callback_express[k.to_sym] = !!v }
          yield
        ensure
          @_callback_express = saved
        end
      else
        express.each{ |k,v| @_callback_express[k.to_sym] = !!v }
      end

      @_callback_express
    end

    # Run the callbacks of a name, a superclass's first, and then the
    # block, which calls super. It is what each callback method calls.
    #
    # Returns what the last callback returned, or what super returned
    # when no callback ran.
    def callback_invoke(name, *args, &superblock)
      name  = name.to_sym
      lists = callback_lists(name)

      if lists.empty? || !callback_express[name]
        return(superblock ? superblock.call : nil)
      end

      result    = nil
      superless = (name == :const_missing)

      lists.each do |list|
        list.dup.each do |entry|
          block, options = entry
          list.delete(entry) if options[:once]
          superless = true if options[:superless]
          if options[:safe]
            callback_express(name=>false) do
              result = block.call(*args, &superblock)
            end
          else
            result = block.call(*args, &superblock)
          end
        end
      end

      superblock.call if superblock && !superless
      result
    end

  private

    # The lists of callbacks of a name, a superclass's before its
    # subclass's, leaving out the empty ones.
    def callback_lists(name)
      lists = []
      owner = self
      while owner
        if owner.instance_variable_defined?(:@_callbacks)
          list = owner.instance_variable_get(:@_callbacks)
          lists.unshift(list[name]) if list.key?(name) && !list[name].empty?
        end
        owner = owner.respond_to?(:superclass) ? owner.superclass : nil
      end
      lists
    end

  end

  # A module for each callback: NoBacksies::MethodAdded and so on.
  CALLBACKS.each do |name|
    mod = Module.new do
      define_singleton_method(:append_features) do |base|
        base.extend CallbackMethods
        base.extend self
      end

      define_method(name) do |arg|
        callback_invoke(name, arg){ super(arg) }
      end
      private name
    end

    const_set(module_name(name), mod)
  end

end
