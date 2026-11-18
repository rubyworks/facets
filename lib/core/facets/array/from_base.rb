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
  # The base can also be given as Integer#to_base takes it for an
  # array: as an array holding the base, or as an array of the digits,
  # starting with the digit for zero. Whatever array `to_base` was
  # given reads its result back.
  #
  #     [10, 0].from_base([100])                  #=> 1000
  #     %w[L O L].from_base(%w[O L T W F S])      #=> 37
  #     [:one, :zero, :one].from_base([:zero, :one])  #=> 5
  #
  # Raises ArgumentError for an empty array, and for an element that
  # isn't a digit of the base: an Integer from 0 to one less than the
  # base, or one of the digits given.
  #
  # String#from_base reads a number written as a string.
  #
  # Since: 4.2.0

  def from_base(base)
    values = nil
    case base
    when ::Integer
      # digit values
    when ::Array
      if base.size == 1 && base.first.is_a?(::Integer)
        base = base.first
      else
        if base.size < 2
          raise ArgumentError, "a base needs at least two digits"
        end
        if base.uniq.size < base.size
          raise ArgumentError, "digits must not repeat"
        end
        values = {}
        base.each_with_index { |d, i| values[d] = i }
        base = base.size
      end
    else
      raise TypeError, "base must be an Integer or Array, not #{base.class}"
    end
    raise ArgumentError, "invalid radix #{base}" if base < 2
    raise ArgumentError, "no digits" if empty?

    inject(0) do |n, d|
      v = values ? values[d] : d
      unless v.is_a?(::Integer) && v >= 0 && v < base
        raise ArgumentError, "invalid digit #{d.inspect} for base #{base}"
      end
      n * base + v
    end
  end

end
