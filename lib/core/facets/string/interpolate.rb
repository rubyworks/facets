class String

  # Interpolate. Provides a means of extenally using
  # Ruby string interpolation mechinism.
  #
  #   try = "hello"
  #   str = "\#{try}!!!"
  #   String.interpolate{ str }    #=> "hello!!!"
  #
  #   NOTE: The block neccessary in order to get
  #         then binding of the caller.
  #
  #   CREDIT: Trans

  def self.interpolate(&str)
    eval "%{#{str.call}}", str.binding
  end

end

