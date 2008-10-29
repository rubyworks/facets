require 'facets/functor'

module Kernel

  # Access internals of an object as if with
  # private access.
  #
  #   class X
  #     metaclass.instance.attr_reader :x
  #   end
  #
  def instance
    @_instance_functor ||= Functor.new do |op,*args|
      send(op,*args)
    end
  end

end

