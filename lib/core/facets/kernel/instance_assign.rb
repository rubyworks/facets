module Kernel

  # Set instance variables using a hash.
  #
  #     instance_assign('@a'=>1, '@b'=>2)
  #     @a   #=> 1
  #     @b   #=> 2
  #
  # NOTE: Conceptually a better alternative to this method is `instance.update`
  #       from the `instance` gem. However, practically this method is probably 
  #       the better choice until such time that Ruby supports anonymous delegators.
  #
  def instance_assign(hash)
    hash.each do |k,v|
      k = "@#{k}" if k !~ /^@/
      instance_variable_set(k, v)
    end
    self
  end

end

