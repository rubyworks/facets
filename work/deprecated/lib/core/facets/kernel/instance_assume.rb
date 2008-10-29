# Deprecated b/c it can be done via instance_assign(obj.to_data).

module Kernel

  # Assign instance vars using another object.
  #
  #   class O
  #     attr_accessor :d
  #     def initialize( a, b, c, d)
  #       @a = a
  #       @b = b
  #       @c = c
  #       @d = d
  #     end
  #   end
  #   o1 = O.new(1,2,3,4)
  #   o2 = O.new(0,0,0,0)
  #
  #   o2.instance_assume( o1, '@a', '@b', '@c', '@d' )
  #   o2.instance_eval{ @a }  #=> 1
  #   o2.instance_eval{ @b }  #=> 2
  #   o2.instance_eval{ @c }  #=> 3
  #   o2.instance_eval{ @d }  #=> 4
  #
  #   CREDIT: Trans

  def instance_assume(obj, *vars)
    if vars.empty?
      vars = obj.instance_variables  # instance_vars | obj.instance_variables
    else
      vars = vars.collect do |k|
        var.to_s.slice(0,1) == '@' ? var : "@#{var}"
      end
      vars = vars | instance_variables | obj.instance_variables
    end
    vars.each do |var|
      instance_variable_set(var, obj.instance_variable_get(var))
    end
    return self  # ???
  end

  # As with #instance_assume, but forces the setting of the object's
  # instance varaibles even if the reciever doesn't have them defined.
  #
  # See #instance_assume.

  def instance_assume!(obj, *vars)
    if vars.empty?
      vars = obj.instance_variables
    else
      vars = vars.collect do |k|
        var.to_s.slice(0,1) == '@' ? var : "@#{var}"
      end
      vars = vars | obj.instance_variables
    end
    vars.each do |var|
      instance_variable_set(var, obj.instance_variable_get(var))
    end
    return self  # ???
  end

  # Shadow method for instance_assume.
  alias :__assume__ :instance_assume if defined?(instance_assume)

end

