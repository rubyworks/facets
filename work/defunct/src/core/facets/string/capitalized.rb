class String

  # Return true if the string is capitalized, otherwise false.
  #
  #   "This".capitalized?  #=> true
  #   "THIS".capitalized?  #=> false
  #   "this".capitalized?  #=> false
  #
  # Note Ruby's strange concept of capitalized. See capitalcase
  # for the more command conception.
  #
  # CREDIT: Phil Tomson

  def capitalized?
    capitalize == self
  end

  # Return true if the string is lowercase (downcase), otherwise false.
  #
  #   "THIS".downcase?  #=> false
  #   "This".downcase?  #=> false
  #   "this".downcase?  #=> true
  #
  # CREDIT: Phil Tomson

  def downcase?
    downcase == self
  end

  # Alias for #downcase? method.
  # alias_method :lowercase?, :downcase?

  # Is the string upcase/uppercase?
  #
  #   "THIS".upcase?  #=> true
  #   "This".upcase?  #=> false
  #   "this".upcase?  #=> false
  #
  # CREDIT: Phil Tomson

  def upcase?
    upcase == self
  end

  # Alias for #upcase? method.
  # alias_method :uppercase?, :upcase?

end

