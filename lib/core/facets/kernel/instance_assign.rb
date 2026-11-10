module Kernel

  # Set instance variables using a hash.
  #
  #     instance_assign('@a'=>1, '@b'=>2)
  #     @a   #=> 1
  #     @b   #=> 2
  #
  # `Mirror#update`, from `require 'facets/mirror'`, does the same
  # through a mirror: `obj.mirror.update(a: 1)`.
  #
  def instance_assign(hash)
    hash.each do |k,v|
      k = "@#{k}" if k !~ /^@/
      instance_variable_set(k, v)
    end
    self
  end

end

