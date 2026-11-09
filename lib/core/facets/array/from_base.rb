class Array

  # Reads the array as the digit values of a number in the given base,
  # most significant first, and returns the number. Any base from 2 up
  # works.
  #
  #     [1, 0].from_base(256)     #=> 256
  #     [100, 10].from_base(256)  #=> 25610
  #     [2, 5, 5].from_base(10)   #=> 255
  #
  # This reverses Ruby's `Integer#digits`, which gives the digit values
  # least significant first:
  #
  #     255.digits(16)                        #=> [15, 15]
  #     255.digits(16).reverse.from_base(16)  #=> 255
  #
  # Raises ArgumentError for an empty array, and for an element that
  # isn't an Integer from 0 to one less than the base.
  #
  # String#from_base reads a number written as a string.
  #
  # Since: 4.2.0

  def from_base(base)
    unless base.is_a?(::Integer)
      raise TypeError, "base must be an Integer, not #{base.class}"
    end
    raise ArgumentError, "invalid radix #{base}" if base < 2
    raise ArgumentError, "no digits" if empty?

    inject(0) do |n, d|
      unless d.is_a?(::Integer) && d >= 0 && d < base
        raise ArgumentError, "invalid digit #{d.inspect} for base #{base}"
      end
      n * base + d
    end
  end

end
