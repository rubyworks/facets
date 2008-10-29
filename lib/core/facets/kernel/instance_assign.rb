module Kernel

  # Return instance variable values in an array.
  #
  #   class X
  #     def initialize(a,b)
  #       @a, @b = a, b
  #     end
  #   end
  #
  #   x = X.new(1,2)
  #
  #   x.instance_values   #=> { "a"=>1, "b"=>2 }
  #
  # WARNING: #instance_values will be deprecated. Use instance_vars.to_hash instead.

  def instance_values
    instance_variables.inject({}) do |values, name|
      values[name[1..-1]] = instance_variable_get(name)
      values
    end
  end

  # Set instance variables using a hash.
  #
  #   instance_assign('@a'=>1, '@b'=>2)
  #   @a   #=> 1
  #   @b   #=> 2
  #
  # WARNING: #instance_assign will be deprecated. Use instance_vars.update instead.

  def instance_assign(hash)
    hash.each do |k,v|
      k = "@#{k}" if k !~ /^@/
      instance_variable_set(k, v)
    end
    return self
  end

end

