class Integer

  # Is +self+ a multiple of a given number?
  #
  #   7.multiple?(2)  #=> false
  #   8.multiple?(2)  #=> true
  #
  # CREDIT: Trans

  def multiple?(number)
    if number.zero?
      zero? ? true : false
    else
      self % number == 0
    end
  end

end

