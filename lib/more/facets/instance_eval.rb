require 'facets/functor'

class Object

  # Access private internals of an object with a fluid notation.
  #
  #   class X
  #     attr :a
  #     private :a
  #     def initialize
  #       @a = 1
  #     end
  #   end
  #
  #   x = X.new
  #   p x.instance_eval.a  #=> 1
  #   p x.a                #=> Error
  #
  # A useful example might include adding accessors to a metaclass.
  #
  #   class X
  #     metaclass.instance_eval.attr :x
  #   end
  #
  # This method is called #instance to go along with methods
  # that provide similar access, such as #instance_variables
  # and #instance_eval. In fact, one could argue this would be
  # a good return value of #instance_eval is no block is given.
  #
  # This method was once called #pry and #privy.
  #
  # TODO: Will only support calls with blocks as of Ruby 1.9+.
  #
  def instance_eval(&block)
    return super if block
    @_instance_eval ||= Functor.new do |op, *a|
      instance_eval{ send(op, *a) }
    end
  end

  # TODO for Ruby 1.9
  #def instance_eval(&block)
  #  return super if block
  #  @_instance_functor ||= Functor.new do |op, *a, &b|
  #    fcall(op, *a, &b)
  #  end
  #end

end

