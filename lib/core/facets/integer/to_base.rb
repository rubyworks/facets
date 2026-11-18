class Integer

  # Converts the integer to a string in any base from 2 to 62, or
  # with a custom set of digits.
  #
  # Ruby's own `to_s(base)` stops at base 36. Above that, the digits are
  # 0-9, then a-z, then A-Z. Up to base 36, the result is the same as
  # `to_s(base)`.
  #
  #     255.to_base(16)              #=> "ff"
  #     255.to_base(62)              #=> "47"
  #     809145531659995.to_base(62)  #=> "3HLszsQsP"
  #     -255.to_base(62)             #=> "-47"
  #
  # To use other digits, give them as a string, starting with the digit
  # for zero. The number of digits is the base.
  #
  #     37.to_base("OLTWFS")         #=> "LOL"
  #
  # In base 256 the digits are bytes, so the result is the number's
  # bytes, most significant first, as a binary string.
  #
  #     256.to_base(256)             #=> "\x01\x00"
  #     0.to_base(256)               #=> "\x00"
  #
  # Combining the two encodes binary data, as with Base58:
  #
  #     b58 = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
  #     "hello".from_base(256).to_base(b58)    #=> "Cn8eVZg"
  #     "Cn8eVZg".from_base(b58).to_base(256)  #=> "hello"
  #
  # This goes through a number, so leading zero bytes are lost:
  # "\x00hi" comes back as "hi". Formats such as Bitcoin's Base58 keep
  # them with their own rules, which this doesn't follow.
  #
  # A negative number gets a leading "-", unless "-" is one of the
  # digits, in which case it raises ArgumentError. That includes base
  # 256, where "-" is byte 45.
  #
  # Given an array, the result is an array, with one element for each
  # digit, most significant first. An array holding one number is a
  # base, of any size from 2 up, and the result is the digit values:
  #
  #     1000.to_base([100])          #=> [10, 0]
  #     256.to_base([256])           #=> [1, 0]
  #     255.to_base([16])            #=> [15, 15]
  #
  # Any other array is the digits themselves, starting with the digit
  # for zero. They can be any objects:
  #
  #     37.to_base(%w[O L T W F S])       #=> ["L", "O", "L"]
  #     37.to_base(%w[O L T W F S]).join  #=> "LOL"
  #     5.to_base([:zero, :one])          #=> [:one, :zero, :one]
  #
  # An array can't show a sign, so a negative number raises
  # ArgumentError.
  #
  # String#from_base converts a string back, and Array#from_base an
  # array.
  #
  # Since: 4.2.0

  def to_base(base)
    case base
    when ::Integer
      if base == 256
        if negative?
          raise ArgumentError, "can't show a negative number in base 256, where '-' is a digit"
        end
        hex = to_s(16)
        hex = "0#{hex}" if hex.size.odd?
        return [hex].pack('H*')
      end
      unless base >= 2 && base <= 62
        hint = base > 62 ? "; for digit values use to_base([#{base}])" : ""
        raise ArgumentError, "invalid radix #{base}#{hint}"
      end
      return to_s(base) if base <= 36
      digits = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"[0, base]
    when ::String
      digits = base.chars
      if digits.size < 2
        raise ArgumentError, "a base needs at least two digits"
      end
      if digits.uniq.size < digits.size
        raise ArgumentError, "digits must not repeat"
      end
      if negative? && digits.include?('-')
        raise ArgumentError, "can't show a negative number when '-' is a digit"
      end
      digits = base
    when ::Array
      if negative?
        raise ArgumentError, "can't show a negative number as an array"
      end
      if base.size == 1 && base.first.is_a?(::Integer)
        raise ArgumentError, "invalid radix #{base.first}" if base.first < 2
        return digits(base.first).reverse
      end
      if base.size < 2
        raise ArgumentError, "a base needs at least two digits"
      end
      if base.uniq.size < base.size
        raise ArgumentError, "digits must not repeat"
      end
      return digits(base.size).reverse.map { |d| base[d] }
    else
      raise TypeError, "base must be an Integer, String or Array, not #{base.class}"
    end

    s = abs.digits(digits.size).reverse.map { |d| digits[d] }.join
    negative? ? "-#{s}" : s
  end

end
