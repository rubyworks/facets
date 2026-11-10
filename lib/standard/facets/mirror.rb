module Kernel

  # A Mirror looks at an object from the outside: its instance variables,
  # its class and its methods. Ruby puts these reflection methods on every
  # object, where a class can redefine them or, like BasicObject, not have
  # them. A mirror calls Ruby's own versions, saved when this file loads,
  # so it gives the true answers for any object.
  #
  #     class Song
  #       def initialize(title, year)
  #         @title, @year = title, year
  #       end
  #     end
  #
  #     song = Song.new("Paranoid", 1970)
  #     mirror = song.mirror        # or Mirror.new(song)
  #
  #     mirror.keys                 #=> [:title, :year]
  #     mirror[:title]              #=> "Paranoid"
  #     mirror.to_h                 #=> {title: "Paranoid", year: 1970}
  #     mirror.update(year: 1971)
  #     mirror[:year]               #=> 1971
  #
  # Instance variable names can be given with or without the "@".
  #
  # The class lives in Kernel, so `Mirror` works everywhere, but an
  # application's own top-level `Mirror` class doesn't clash with it: the
  # application's takes precedence, and this one is still
  # `Kernel::Mirror`. A class can also define its own `#mirror`, so code
  # that must work on any object should use `Mirror.new(obj)`.
  #
  # NOTE: This is not loaded by `require 'facets'`. Use:
  #
  #     require 'facets/mirror'
  #
  # Based on the Instance gem.
  #
  # Since: 4.2.0
  # Author: Trans

  class Mirror
    include Enumerable

    # Ruby's own reflection methods, saved so that later changes to them,
    # or an object that redefines them, can't affect a mirror. Methods
    # from Kernel and BasicObject can be called on any object, including
    # a BasicObject.
    KERNEL = %i[
      class instance_of? kind_of? object_id to_s
      instance_variables instance_variable_get instance_variable_set
      instance_variable_defined? remove_instance_variable
      methods public_methods protected_methods private_methods
      singleton_methods method
    ].to_h { |name| [name, ::Kernel.instance_method(name)] }.merge(
      %i[instance_eval instance_exec].to_h { |name| [name, ::BasicObject.instance_method(name)] }
    ).freeze

    # Ruby's own Module reflection methods, for a mirror of a module or
    # class.
    MODULE = %i[
      instance_methods public_instance_methods protected_instance_methods
      private_instance_methods instance_method
    ].to_h { |name| [name, ::Module.instance_method(name)] }.freeze

    private_constant :KERNEL, :MODULE

    # A mirror of +object+.
    def initialize(object)
      @object = object
    end

    # The object this mirror reflects.
    attr_reader :object

    # Instance variable names as Ruby gives them, with the "@".
    #
    #     mirror.variables  #=> [:@title, :@year]
    def variables
      call(:instance_variables)
    end

    # Instance variable names as symbols, without the "@".
    #
    #     mirror.keys  #=> [:title, :year]
    def keys
      variables.map { |name| name[1..-1].to_sym }
    end

    # Instance variable values, in the same order as #keys.
    def values
      variables.map { |name| call(:instance_variable_get, name) }
    end

    # Number of instance variables.
    def size
      variables.size
    end

    # Yields each instance variable's name, without the "@", and value.
    # Mirror is Enumerable, so `to_h`, `select` and the rest work too.
    #
    #     mirror.to_h  #=> {title: "Paranoid", year: 1970}
    def each
      return to_enum(:each) { size } unless block_given?
      variables.each do |name|
        yield name[1..-1].to_sym, call(:instance_variable_get, name)
      end
      self
    end

    # Value of an instance variable, or nil if it isn't set.
    def get(name)
      call(:instance_variable_get, ivar(name))
    end
    alias_method :[], :get

    # Sets an instance variable, and returns the value.
    def set(name, value)
      call(:instance_variable_set, ivar(name), value)
    end
    alias_method :[]=, :set

    # Sets instance variables from a hash of names and values, and
    # returns the mirror.
    #
    #     mirror.update(title: "War Pigs", year: 1970)
    def update(hash)
      hash.each { |name, value| set(name, value) }
      self
    end

    # Is the instance variable set?
    def key?(name)
      call(:instance_variable_defined?, ivar(name))
    end

    # Removes an instance variable, and returns its value. Raises
    # NameError if it isn't set.
    def remove(name)
      call(:remove_instance_variable, ivar(name))
    end

    # Evaluates a string or a block with the object as self, like
    # `instance_eval`.
    def eval(*args, &block)
      call(:instance_eval, *args, &block)
    end

    # Calls the block with the object as self, passing the arguments, like
    # `instance_exec`.
    def exec(*args, &block)
      call(:instance_exec, *args, &block)
    end

    # The object's class, even if the object redefines #class.
    def object_class
      call(:class)
    end

    # Is the object an instance of exactly this class?
    def of?(klass)
      call(:instance_of?, klass)
    end

    # Is the object an instance of this class or module, or of a
    # subclass, as with `is_a?`?
    def is?(mod)
      call(:kind_of?, mod)
    end

    # The object's object_id.
    def id
      call(:object_id)
    end

    # Names of the object's methods. With no arguments, the same as
    # `methods`. Otherwise any of :public, :protected, :private and
    # :singleton, or :all for the first three.
    #
    #     mirror.method_names(:private)
    def method_names(*kinds)
      return call(:methods) if kinds.empty?
      kinds = [:public, :protected, :private] if kinds.include?(:all)
      kinds.uniq.flat_map do |kind|
        case kind
        when :public    then call(:public_methods)
        when :protected then call(:protected_methods)
        when :private   then call(:private_methods)
        when :singleton then call(:singleton_methods)
        else raise ArgumentError, "unknown kind of method: #{kind.inspect}"
        end
      end
    end

    # The object's method of this name, as a Method, even if the object
    # redefines #method.
    def method_object(name)
      call(:method, name)
    end

    # For a module or class: names of the methods it defines for its
    # instances. With no arguments, the same as `instance_methods`.
    # Otherwise any of :public, :protected and :private, or :all.
    # Raises TypeError for any other object.
    def method_definitions(*kinds)
      return module_call(:instance_methods) if kinds.empty?
      kinds = [:public, :protected, :private] if kinds.include?(:all)
      kinds.uniq.flat_map do |kind|
        case kind
        when :public    then module_call(:public_instance_methods)
        when :protected then module_call(:protected_instance_methods)
        when :private   then module_call(:private_instance_methods)
        else raise ArgumentError, "unknown kind of method: #{kind.inspect}"
        end
      end
    end

    # For a module or class: the instance method of this name, as an
    # UnboundMethod. Raises TypeError for any other object.
    def method_definition(name)
      module_call(:instance_method, name)
    end

    # Two mirrors are equal if they reflect the same object.
    def ==(other)
      other.is_a?(Mirror) && other.object.equal?(@object)
    end
    alias_method :eql?, :==

    def hash
      [Mirror, id].hash
    end

    # Shows the object's class and address, without calling the
    # object's own #inspect, which it may not have.
    def inspect
      "#<#{self.class} of #{call(:to_s)}>"
    end

    private

    def call(name, *args, &block)
      KERNEL.fetch(name).bind_call(@object, *args, &block)
    end

    def module_call(name, *args)
      unless call(:kind_of?, ::Module)
        raise TypeError, "#{call(:class)} is not a module or class"
      end
      MODULE.fetch(name).bind_call(@object, *args)
    end

    def ivar(name)
      name = name.to_s
      name.start_with?('@') ? name.to_sym : :"@#{name}"
    end
  end

  # A Mirror of this object, for looking at its instance variables,
  # class and methods from the outside.
  #
  #     song.mirror.to_h  #=> {title: "Paranoid", year: 1970}
  #
  # A class can define its own #mirror. To be sure of getting a mirror
  # for any object, use `Mirror.new(obj)`.
  #
  # NOTE: This is not loaded by `require 'facets'`. Use:
  #
  #     require 'facets/mirror'
  #
  # Since: 4.2.0
  def mirror
    ::Kernel::Mirror.new(self)
  end

end
