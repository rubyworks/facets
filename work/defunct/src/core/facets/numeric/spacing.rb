class Numeric

  # Returns the size of the string representation of
  # a numerical value.
  #
  #      1.spacing   #=> 1
  #     10.spacing   #=> 2
  #    100.spacing   #=> 3
  #   -100.spacing   #=> 4
  #    1.2.spacing   #=> 3
  #
  # CREDIT: Victor H. Goff III

  def spacing
    to_s.length
  end

end


