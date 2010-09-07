class Object

  # Replace state of object with the state of another object of the
  # same class (or superclass).
  #
  #   class ReplaceExample
  #     attr_reader :a, :b
  #     def initialize(a,b)
  #       @a, @b = a, b
  #     end
  #   end
  #
  #   obj1 = ReplaceExample.new(1,2)
  #   obj1.a  #=> 1
  #   obj1.b  #=> 2
  #
  #   obj2 = ReplaceExample.new(3,4)
  #   obj1.a  #=> 3
  #   obj1.b  #=> 4
  #
  #
  #   obj1.replace(obj2)
  #   obj1.a  #=> 3
  #   obj1.b  #=> 4
  #
  # This is very similar to <code>instance.update</code>, but it is limited
  # by the class of objects, in the same manner as Array#replace.
  def replace(source)
    raise ArgumentError, "not a #{self.class}" unless source.is_a?(self.class)
    instance_variables.each do |iv|
      instance_variable_set(iv, source.instance_variable_get(iv))
    end
  end

end

class Struct

  # Struct#replace can take a hash.
  def replace(source)
    source.each_pair{ |k,v| send(k.to_s + "=", v) }
  end

end
