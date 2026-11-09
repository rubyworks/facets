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
  # To use other digits, give them as a string or an array of
  # single characters, starting with the digit for zero. The number of
  # digits is the base.
  #
  #     37.to_base("OLTWFS")         #=> "LOL"
  #     37.to_base(%w[O L T W F S])  #=> "LOL"
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
  # String#from_base converts back. For digit values in any base, as
  # an array, use Ruby's `digits(base).reverse`, and Array#from_base to
  # convert back.
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
        raise ArgumentError, "invalid radix #{base}"
      end
      return to_s(base) if base <= 36
      digits = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"[0, base]
    when ::String, ::Array
      digits = base.is_a?(::Array) ? base.map(&:to_s) : base.chars
      unless digits.all? { |d| d.length == 1 }
        raise ArgumentError, "digits must be single characters"
      end
      if digits.size < 2
        raise ArgumentError, "a base needs at least two digits"
      end
      if digits.uniq.size < digits.size
        raise ArgumentError, "digits must not repeat"
      end
      if negative? && digits.include?('-')
        raise ArgumentError, "can't show a negative number when '-' is a digit"
      end
      digits = digits.join
    else
      raise TypeError, "base must be an Integer, String or Array, not #{base.class}"
    end

    s = abs.digits(digits.size).reverse.map { |d| digits[d] }.join
    negative? ? "-#{s}" : s
  end

end
