class Integer

  # Calculate the factorial of an integer.
  #
  #   2.factorial  #=> 2
  #   3.factorial  #=> 6
  #   4.factorial  #=> 24
  #
  # CREDIT: Malte Milatz

  def factorial
    return 1 if zero?
    f = 1
    2.upto(self) { |n| f *= n }
    f
  end

  alias_method( :fac, :factorial )

end

