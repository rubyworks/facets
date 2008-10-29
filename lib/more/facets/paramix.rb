# TITLE:
#
#   Parametric Mixins
#
# SUMMARY:
#
#   Parametric Mixins provides parameters for mixin modules.
#
# COPYRIGHT:
#
#   Copyright (c) 2008 T. Sawyer
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
#   - Thomas Sawyer

require 'facets/module/basename'
require 'facets/module/modspace'

# = Parametric Mixin
#
# Parametric Mixins provides parameters for mixin modules.
# Module parameters can be set at the time of inclusion 
# or extension using Module#[] method, then parameters
# can be accessed via the #mixin_parameters method.
#
#   module MyMixin
#     include Paramix
#
#     def hello
#       puts "Hello from #{mixin_parameters[MyMixin][:name]}!"
#     end
#   end
#
#   class MyClass
#     include Mixin[:name => 'Ruby']
#   end
#
#   m = MyClass.new
#   m.hello -> 'Hello from Ruby!'
#
# You can view the full set of parameters via the #mixin_parameters
# class method, which returns a hash keyed on the included modules.
#
#   MyClass.mixin_parameters         #=> {MyMixin=>{:name=>'Ruby'}}
#   MyClass.mixin_parameters[MyMixin]  #=> {:name=>'ruby'}
#
# The include Praamix is equivalent to:
#
#   def [](parameters)
#     Paramix.new(self, parameters)
#   end
#
# Paramix.new can also take a block that injects code into the class
# or module including the parametric mixin. This is useful as an
# alternative to using the #included callback for creating dynamic
# mixins.. For example:
#
#   def self.[](parameters)
#     Paramix.new(self, parameters) do
#       attr_accessor mixin_params[MyMixin][:name]
#     end
#   end
#
# As opposed to:
#
#   module Mixin
#     def self.included(base)
#       base.class_eval do
#         attr_accessor mixin_params[MyMixin][:name]
#       end
#     end
#   end
#
#--
# More conveniently a new callback has been added, #included_with_parameters,
# which passes in the parameters in addition to the base class/module.
#
#   module Mixin
#     def self.included_with_parameters( base, parms )
#       base.class_eval {
#         def hello
#           puts "Hello from #{mixin_parameters[Mixin][:name]}"
#         end
#       }
#     end
#   end
#
# We would prefer to have passed the parameters through the #included callback
# method itself, but implementation of such a feature is much more complicated.
# If a reasonable solution presents itself in the future however, we will fix.
#++

module Paramix  # or PatrametricMixin ?

  def self.append_features(base)
    (class << base; self; end).class_eval do
      define_method(:[]) do |parameters|  # TODO until 1.9 no &block
        Delegator.new(base, parameters)
      end
    end
  end

  # It you want to define the module's ::[] method by hand. You
  # can use Paramix.new instead of Paramix::Delegator.new.

  def self.new(delegate_module, parameters={}, &base_block)
    Delegator.new(delegate_module, parameters, &base_block)
  end

  #

  class Delegator < Module

    attr :module_delegate
    attr :parameters
    attr :base_block

    #

    def initialize(module_delegate, parameters={}, &base_block)
      @module_delegate = module_delegate
      @parameters      = parameters
      @base_block      = base_block
    end

    #

    def append_features(base)
      base.mixin_parameters[module_delegate] = parameters

      base.module_eval do 
        define_method(:mixin_parameters) do
          base.mixin_parameters
        end
        alias_method :mixin_params, :mixin_parameters
      end

      base.module_eval(&@base_block) if base_block

      base.__send__(:include, module_delegate)
    end

    #

    def extend_object(base)
      baseclass = (class << base; self; end)

      baseclass.mixin_parameters[module_delegate] = parameters

      baseclass.module_eval do 
        define_method(:mixin_parameters) do
          baseclass.mixin_parameters
        end
        alias_method :mixin_params, :mixin_parameters
      end

      baseclass.module_eval(&@base_block) if base_block

      base.__send__(:extend, module_delegate)
    end

    def [](name)
      @parameters[name]
    end

  end

end


class Module

  # Store for parametric mixin parameters.
  #
  # Returns a hash, the keys of which are the parametric mixin module
  # and the values are the parameters associacted with this module/class.
  #
  #   class C
  #     include P(:x=>1)
  #   end
  #
  #   C.mixin_parameters[P]   #=> {:x=>1}
  #
  def mixin_parameters
    @mixin_parameters ||= {}
  end
  alias_method :mixin_params, :mixin_parameters

end

