module Kernel

  # Set instance variables using a hash.
  #
  #   instance_assign('@a'=>1, '@b'=>2)
  #   @a   #=> 1
  #   @b   #=> 2
  #
  # DEPRECATE: Use instance.update instead of #instance_assign.

  def instance_assign(hash)
    hash.each do |k,v|
      k = "@#{k}" if k !~ /^@/
      instance_variable_set(k, v)
    end
    return self
  end

end

