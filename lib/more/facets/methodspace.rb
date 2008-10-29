# = Method Namespaces
#
# Create method namespaces, allowing for method
# chains but still accessing the object's instance.
#
# == Todo
#
# * May need to cahnge name, to avoid conflict with Rake's method by the same name.
# * Maybe can become part of core once name is changed.
#
# == Authors
#
# * Thomas Sawyer
# * Pit Captain
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer, Pit Captain
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'facets/functor'
require 'facets/module' # for Module#basename

class Module

  # Define a simple method namespace.
  #
  #   class A
  #     attr_writer :x
  #     method_space :inside do
  #       def x; @x; end
  #     end
  #   end
  #
  #   a = A.new
  #   a.x = 10
  #   a.inside.x #=> 10
  #   a.x  # no method error

  def method_space(name, mod=nil, &blk)

    # If block is given then create a module, otherwise
    # get the name of the module.
    if block_given?
      name = name.to_s
      raise ArgumentError if mod
      mod  = Module.new(&blk)
    else
      if Module === name
        mod = name
        name = mod.basename.downcase
      end
      mod  = mod.dup
    end

    # Include the module. This is neccessary, otherwise
    # Ruby won't let us bind the instance methods.
    include mod

    # Save the instance methods of the module and
    # replace them with a "transparent" version.
    methods = {}
    mod.instance_methods(false).each do |m|
      methods[m.to_sym] = mod.instance_method(m)
      mod.instance_eval do
        define_method(m) do
          super
        end
      end
    end

    # Add a method for the namespace that delegates
    # via the Functor to the saved instance methods.
    define_method(name) do
      mtab = methods
      Functor.new do |op, *args|
        mtab[op].bind(self).call(*args)
      end
    end
  end

  # Include a module via a specified space.
  #
  #   module T
  #     def t ; "HERE" ; end
  #   end
  #
  #   class X
  #     include_as :test => T
  #     def t ; test.t ; end
  #   end
  #
  #   X.new.t  #=> "HERE"
  #
  def include_as(h)
    h.each{ |name, mod| method_space(name, mod) }
  end

end




# demonstration

=begin demo

  module T
    def t ; p self ; end
    def r ; p self ; end
    def q ; super ; end
  end

  class N
    def q ; puts "ho" ; end
  end

  class X < N
    include_as :test => T

    def n ; p test ; end
    def m ; test.t ; end
    def o ; test.r ; end
  end

  x = X.new
  x.n
  x.m
  x.o
  x.q

=end

