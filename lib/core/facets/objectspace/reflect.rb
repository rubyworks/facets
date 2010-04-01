require 'facets/functor'

class << ObjectSpace

  # Reflection ensures that information about an object
  # is actual according to Ruby's Kernel definitions, just
  # in case such methods have been overridden.
  #
  #  ObjectSpace.reflect(obj).id
  #
  #--
  # There is also a global short-cut for this method to ease
  # meta-programming with it.
  #
  #   $ref[obj].id
  #++
  #
  # Typically theis method will be used to gather the object's
  # id, as in the example given, or it's class, but any Kernel
  # method can be used.
  #
  # Care should be taken in utilizing this technique. In most
  # cases it is not needed, but in certain cases is useful
  # for improving the robustness of meta-programming solutions.
  #
  # Note that this is also equivalent to using +as(Kernel)+:
  #
  #   obj.as(Kernel).id
  #
  # But obviously, in this case there is the risk that #as has
  # be overridden too.
  #
  def reflect(obj)
    Functor.new do |meth, *a, &b|
      Kernel.instance_method(meth).bind(obj).call(*a, &b)
    end
  end

end

# TODO: Consider this "Shorcut for +ObjectSpace.reflect+."
#$ref = lambda do |obj|
#  ObjectSpace.reflect(obj)
#end

