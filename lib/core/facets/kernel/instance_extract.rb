module Kernel

  # Like `instance_assign`, but only assigns an instance variable if
  # it does not already exist.
  #
  #     @a = 9
  #     instance_extract('@a'=>1, '@b'=>2)
  #     @a   #=> 9
  #     @b   #=> 2
  #
  # CREDIT: T. Yamada

  def instance_extract(hash)
    hash.each do |k,v|
      k = "@#{k}" if k !~ /^@/
      instance_variable_set(k, v) unless instance_variable_defined?(k)
    end
    self
  end

end

