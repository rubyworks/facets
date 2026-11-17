# Paramix namespace.
#
# NOTE: This is not loaded by `require 'facets'`. Use:
#
#     require 'facets/paramix'
#
# Based on the Paramix gem.
#
# Since: 4.2.0
# Author: Trans

module Paramix

  # A parametric mixin is a module that takes parameters where it is
  # included or extended, with `Module[parameters]`. Its `parameterized`
  # block is given the parameters, and defines the methods that depend
  # on them.
  #
  #     module Greeter
  #       include Paramix::Parametric
  #
  #       parameterized do |params|
  #         define_method :hello do
  #           "Hello from #{params[:name]}!"
  #         end
  #       end
  #     end
  #
  #     class English
  #       include Greeter[:name => 'England']
  #     end
  #
  #     class Scots
  #       include Greeter[:name => 'Scotland']
  #     end
  #
  #     English.new.hello  #=> "Hello from England!"
  #     Scots.new.hello    #=> "Hello from Scotland!"
  #
  # Each use of `Module[parameters]` makes a new module that includes the
  # parametric one, so each class gets its own methods. The block runs in
  # that module, where `public`, `private` and `protected` also define a
  # method when given a block:
  #
  #     module Named
  #       include Paramix::Parametric
  #
  #       parameterized do |params|
  #         public(params[:as]) { params[:value] }
  #       end
  #     end
  #
  #     class Config
  #       extend Named[:as => :env, :value => 'test']
  #     end
  #
  #     Config.env  #=> "test"
  #
  # A module that includes a parametric module without giving it
  # parameters becomes parametric too, and passes its own parameters on.

  module Parametric

    #
    def self.included(base)
      base.extend(Extensions)
    end

    # Class-level methods of a parametric module.
    module Extensions

      # Apply parameters, giving a module to include or extend.
      #
      # Returns a new Mixin. [Mixin]
      def [](parameters={})
        Mixin.new(self, parameters)
      end

      # Add a block to run when parameters are applied. Without a block,
      # gives the blocks added so far.
      #
      # Returns the list of blocks. [Array<Proc>]
      def parameterized(&code)
        @code ||= []
        if block_given?
          @code << code
        else
          @code
        end
      end

      #
      def append_features(base)
        return super(base) if Mixin === base || Mixin === self

        base.extend(Extensions)

        anc = ancestors.find{ |a| a.respond_to?(:parameterized) }
        base.parameterized.concat(anc.parameterized)

        super(base)
      end

      #
      def extend_object(base)
        return super(base) if Mixin === base || Mixin === self

        base.extend(Extensions)

        anc = ancestors.find{ |a| a.respond_to?(:parameterized) }
        base.parameterized.concat(anc.parameterized)

        super(base)
      end

    end

    # An instance of the Mixin module class is what is produced
    # when parameters are applied to a parametric module.
    #
    class Mixin < Module

      def initialize(base, parameters)
        super()
        include(base)
        base.parameterized.each do |code|
          instance_exec(parameters, &code)
        end
      end

      # As Module#public, and given a block, define the method first.
      def public(*names, &code)
        define_method(names.first, &code) if code
        super(*names)
      end

      # As Module#private, and given a block, define the method first.
      def private(*names, &code)
        define_method(names.first, &code) if code
        super(*names)
      end

      # As Module#protected, and given a block, define the method first.
      def protected(*names, &code)
        define_method(names.first, &code) if code
        super(*names)
      end

    end

  end

end
