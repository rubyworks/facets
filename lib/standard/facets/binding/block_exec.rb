class Binding

  # Allows the evaluation of blocks by a Binding in the same way that strings
  # can be evaluated.
  #
  #   x = 5
  #   $my_binding = binding
  #
  #   class Test  # just here to provide a scope gate
  #     $my_binding.block_exec { x }
  #   end
  #
  #   # => 5
  #
  # NOTE: The implementation of this method uses a method_missing trick.
  #       Consequently it is a bit of a hack.
  #
  def block_exec(*args, &block)
    BlockEnvironment.new(self, *args, &block).call
  end

  # This class is used for evaluating blocks in a particular context. 
  # It is not really meant to be used independently; instead it is used
  # with Binding#block_exec method.

  class BlockEnvironment < BasicObject

    def initialize(context, *args, &block)
      @context = context
      @args = args
      @block = block
    end

    def call
      instance_exec(*@args, &@block)
    end

    def method_missing(name)
      eval(name.to_s, @context) rescue super
    end

  end

end
