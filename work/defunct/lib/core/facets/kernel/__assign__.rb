module Kernel

  # Universal assignment. This is a meta-programming
  # method, which allows you to assign any type of variable.
  #
  # TODO: This method is probably worthless. Either depreicate
  #       Or just move to a separate file.
  #
  #  CREDIT: Trans

  def __assign__(name, value)
    k = name.to_s
    v = value
    /^([@$]{0,2})/ =~ k
    case $1
    when '$', '@@'
      instance_eval %Q{ #{k} = v }
    when '@'
      instance_variable_set( k, v )
    else
      return __send__( "#{k}=", v ) if respond_to?("#{k}=")
      # No accessor? What to do? Assume instance var, or error? ...
      self.instance_variable_set( "@#{k}", v )
    end
    return value
  end

end
