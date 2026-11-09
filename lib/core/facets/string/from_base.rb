class String

  # Reads the string as a number in any base from 2 to 62, or with a
  # custom set of digits, and returns it as an Integer.
  #
  # Ruby's own `to_i(base)` stops at base 36. Above that, the digits are
  # 0-9, then a-z, then A-Z. Up to base 36, case doesn't matter, as with
  # `to_i(base)`.
  #
  #     "ff".from_base(16)          #=> 255
  #     "FF".from_base(16)          #=> 255
  #     "47".from_base(62)          #=> 255
  #     "3HLszsQsP".from_base(62)   #=> 809145531659995
  #     "-47".from_base(62)         #=> -255
  #
  # To use other digits, give them as a string or an array of
  # single characters, starting with the digit for zero.
  #
  #     "LOL".from_base("OLTWFS")         #=> 37
  #     "LOL".from_base(%w[O L T W F S])  #=> 37
  #
  # In base 256 the digits are bytes, so this reads the string's bytes,
  # most significant first, whatever its encoding.
  #
  #     "\x01\x00".from_base(256)  #=> 256
  #
  # Unlike `to_i`, which stops at the first character it can't read,
  # this raises ArgumentError for a character that isn't a digit of the
  # base, and for an empty string. A leading "-" makes the number
  # negative, unless "-" is one of the digits, as it is in base 256.
  #
  # Integer#to_base converts back.
  #
  # Since: 4.2.0

  def from_base(base)
    case base
    when ::Integer
      if base == 256
        raise ArgumentError, "no digits in #{inspect}" if empty?
        return unpack1('H*').to_i(16)
      end
      unless base >= 2 && base <= 62
        raise ArgumentError, "invalid radix #{base}"
      end
      digits = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"[0, base].chars
      ignore_case = base <= 36
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
      ignore_case = false
    else
      raise TypeError, "base must be an Integer, String or Array, not #{base.class}"
    end

    values = {}
    digits.each_with_index do |d, i|
      values[d] = i
      values[d.upcase] = i if ignore_case
    end

    str = self
    negative = str.start_with?('-') && !values.key?('-')
    str = str[1..-1] if negative
    raise ArgumentError, "no digits in #{inspect}" if str.empty?

    n = 0
    str.each_char do |c|
      v = values[c]
      raise ArgumentError, "invalid digit #{c.inspect} in #{inspect}" unless v
      n = n * digits.size + v
    end
    negative ? -n : n
  end

end
