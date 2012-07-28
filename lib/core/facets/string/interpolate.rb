class String

  # Interpolate provides a means of externally using Ruby string
  # interpolation mechinism.
  #
  #   try = "hello"
  #   str = "\#{try}!!!"
  #   String.interpolate{ str }    #=> "hello!!!"
  #
  # Note this uses #eval under the hood. We do not recommend that
  # it serve in place of a good templating system. But, it can be
  # useful for simple cases.
  #
  # The block is neccessary in order to get then binding of the caller.
  #
  # CREDIT: Trans

  def self.interpolate(&str)
    eval "%{#{str.call}}", str.binding
  end

end

