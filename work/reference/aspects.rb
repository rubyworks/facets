# TITLE:
#
#   Aspects
#
# DESCRIPTION:
#
#   An Aspect is mixin of AOP meta-methods for defining advice.
#
# COPYRIGHT:
#
#   Copyright (c) 2005 George Moschovitis
#
# LICENSE:
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#
# AUTHORS:
#
#   - George Moschovitis


require 'facets/inheritor'


# = Aspect
#
# An Aspect is a class that defines advices.
#
# == Usage
#
# George, please do!
#

class Aspect
  class << self
    def wrap(target, methods = target.instance_methods, pre = :pre, post = :post)
      target.send(:include, Aspects) unless target.ancestors.include?(Aspects)
      target.wrap(self, :pre => pre, :post => post)
    end

    alias_method :observe, :wrap
  end

  def wrap(target, methods = target.instance_methods, pre = :pre, post = :post)
    target.send(:include, Aspects) unless target.ancestors.include?(Aspects)
    target.wrap(self, :pre => pre, :post => post)
  end
  alias_method :observe, :wrap
end

# Add support for Aspect Oriented Programming (AOP).
#
# === Examples
#
# class Controller
#   pre :force_login, :where => :prepend
#   wrap Benchmark, :on => :index
#   post :taraa, :on => login
# end
#
# module Timestamped
#   pre :on => :og_insert { |this| this.create_time = Time.now }
#   pre :on => :og_update { |this| this.update_time = Time.now }
#   pre :on => [:og_insert, :og_update] { |this| this.create_time = Time.now }
# end

module Aspects

  # Store the code and the metadata (options) for
  # an Advice.

  Advice = Struct.new(:code, :options)

  # Apply the advices to the target class.

  def self.wrap(target, methods = target.instance_methods)
    include_advice_modules(target)

    for m in [methods].flatten
      target.module_eval <<-end_eval, __FILE__, __LINE__
        alias_method :__unwrapped_#{m}, :#{m}
        def #{m}(*args,&block)
          #{gen_advice_code(m, target.advices, :pre)}
          __unwrapped_#{m}(*args,&block)
          #{gen_advice_code(m, target.advices, :post)}
        end
      end_eval
    end
  end

  class << self
    alias_method :apply_advices, :wrap
  end

  # Include Modules that define advices.

  def self.include_advice_modules(target)
    add_advices = []
    del_advices = []

    for a in target.advices
      if a.code.is_a?(Module) and (!a.code.class.ancestors.include?(Class))
        target.module_eval %{ include #{a.code} }

        options = a.options.reject { |k,v| k == :pre || k == :post }

        method = (a.options[:pre] || 'pre').to_s
        if a.code.instance_methods.include?(method)
          options.update(:where => :prepend, :join => :pre)
          add_advices <<  Advice.new(method.to_sym, options)
        end

        method = (a.options[:post] || 'post').to_s
        if a.code.instance_methods.include?(method)
          options.update(:where => :append, :join => :post)
          add_advices <<  Advice.new(method.to_sym, options)
        end

        del_advices << a
      end
    end

    # Delete the original advices.

    for a in del_advices
      target.advices!.delete(a)
    end

    # Add the new advices.

    target.advices!.concat(add_advices)
  end

  # Generates the code to call the aspects.

  def self.gen_advice_code(method, advices, join = :pre) # :nodoc:
    code = ''

    advices.each_with_index do |advice, idx|
      o = options = advice.options

      if only = options[:only] || options[:on]
        next unless [only].flatten.include?(method.to_sym)
      elsif except = options[:except]
        next if [except].flatten.include?(method.to_sym)
      end

      advice = advice.code

      if advice.is_a?(Symbol) or advice.is_a?(String)
        next if o[:join] != join
        code << "#{advice}; "
      elsif advice.respond_to?('call')
        next if o[:join] != join
        code << "self.class.advices[#{idx}].code.call(self); "
      elsif advice.is_a?(Class)
        if advice.class.ancestors.include?(Class)
          if m = o[join] and advice.methods.include?(m.to_s)
            code << "#{advice}.#{m}(self); "
          end
        else
          # Module, already handled.
        end
      else
        if m = o[join] and advice.methods.include?(m.to_s)
          code << "self.class.advices[#{idx}].code.#{m}(self); "
        end
      end
    end

    return code
  end

  def self.append_features(base)
    super
    base.extend(ClassMethods)
    base.inheritor :advices, [], :+
  end

  module ClassMethods #:nodoc:

    # Add a pre (before) advice.

    def pre(*args, &block)
      o = options = {
        :join => :pre,
        :where => :prepend,
      }
      options.update(args.pop) if args.last.is_a?(Hash)

      if block_given?
        new_advices = [ Advice.new(block, options) ]
      else
        new_advices = args.collect { |a| Advice.new(a, options) }
      end
#       if options[:where] == :prepend
#         self.advices = advices + self.advices
#       else
#         self.advices = self.advices + advices
#       end
      self.advices!.concat(new_advices)
    end
    alias_method :before, :pre

    # Add a post (after) advice.

    def post(*args, &block)
      o = options = {
        :join => :post,
        :where => :append,
      }
      options.update(args.pop) if args.last.is_a?(Hash)

      if block_given?
        new_advices = [ Advice.new(block, options) ]
      else
        new_advices = args.collect { |a| Advice.new(a, options) }
      end
#       if options[:where] == :prepend
#         self.advices = advices + self.advices
#       else
#         self.advices = self.advices + advices
#       end
      self.advices!.concat(new_advices)
    end
    alias_method :after, :post

    # Add a wrap (arround) aspect. An aspect is a class that
    # responds to the before and after advices.

    def wrap(*args)
      o = options = {
        :pre => :pre,
        :post => :post
      }
      options.update(args.pop) if args.last.is_a?(Hash)

      for aspect in args
        self.advices! << Advice.new(aspect, options)
      end
    end
    alias_method :around, :wrap
    alias_method :observer, :wrap

  end

end
