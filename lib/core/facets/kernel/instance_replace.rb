module Kernel

  # Replace state of object with the state of another object of the
  # same class (or superclass).
  #
  #     class ReplaceExample
  #       attr_reader :a, :b
  #       def initialize(a,b)
  #         @a, @b = a, b
  #       end
  #     end
  #
  #     obj1 = ReplaceExample.new(1,2)
  #     obj1.a  #=> 1
  #     obj1.b  #=> 2
  #
  #     obj2 = ReplaceExample.new(3,4)
  #     obj2.a  #=> 3
  #     obj2.b  #=> 4
  #
  #     obj1.instance_replace(obj2)
  #     obj1.a  #=> 3
  #     obj1.b  #=> 4
  #
  # This is very similar to `instance.assign`, but it is limited
  # by the class of object, in the same manner as Array#replace.
  #
  # NOTE: Conceptually a better alternative is `instance.replace` provided
  #       by the `instance` gem. However, practically this method is probably 
  #       the better choice until such time that Ruby support anonymous delegators.
  #
  def instance_replace(source)
    raise ArgumentError, "not a #{self.class} -- #{source}" unless source.is_a?(self.class)
    instance_variables.each do |iv|
      instance_variable_set(iv, source.instance_variable_get(iv))
    end
  end

end

