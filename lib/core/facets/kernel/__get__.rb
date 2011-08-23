module Kernel

  # Shadow method for instance_variable_get.
  def __get__(ivar)
    #ivar = "@#{ivar}" unless ivar.to_s[0,1] == '@'
    instance_variable_get(ivar)
  end

  # Shadow method for instance_variable_set.
  def __set__(ivar, val)
    #ivar = "@#{ivar}" unless ivar.to_s[0,1] == '@'
    instance_variable_set(ivar, val)
  end

end
