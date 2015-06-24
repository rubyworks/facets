class Numeric
  # Returns a string representation of the number e.g.
  #   1000.delimit # => "1,000"
  #   1000000.delimit # => "1,000,000"
  #   (1000000.1234).delimit # => "1,000,000.1234"
  #
  # Can take a hash of options:
  # * <tt>delimiter</tt> - defaults to "," but can be any string
  # * <tt>separator</tt> - defaults to "." but can be any string
  #
  #   1000.delimit(:delimiter => "_") # => "1_000"
  #   (1000.00).delimit(:delimiter => ".", :separator => ",") # => "1.000,00"
  def delimit(options = {})
    opts = { :delimiter => ',', :separator => '.' }.merge(options)
    digits, decimals = self.to_s.split('.')
    digits = digits.reverse.chars.each_slice(3).map(&:join).join(opts[:delimiter]).reverse
    return digits unless decimals
    [digits, decimals].join(opts[:separator])
  end
end
