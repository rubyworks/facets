class String

  # Returns true if it's a decimal digits.
  #
  #   "123_456_789_123_456_789.123_456_000_111".number?  # => true
  #   "1.23".number?  # => true
  #   "1.23a".number? # => false
  #
  # CREDIT: u2

  def number?
    !!self.match(/\A[+-]?\d+?(_?\d+?)*?(\.\d+(_?\d+?)*?)?\Z/)
  end
end