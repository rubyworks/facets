class BaseX

  BASE62 = ["0".."9", "a".."z", "A".."Z"].map { |r| r.to_a }.flatten

  attr :chars, :base, :values

  def initialize(chars=BASE62)
    @chars  = chars
    @base   = @chars.size
    @values = Hash[*(0...@base).map { |i| [ @chars[i], i ] }.flatten]
  end

  def encode(byte_string)
    convert_base(byte_string.unpack("C*"), 256, @base).map { |d|
      @chars[d]
    }.join('')
  end

  def decode(encoded)
    convert_base(encoded.split('').map { |c|
      @values[c]
    }, @base, 256).pack("C*")
  end

  def convert_base(digits, from_base, to_base)
    bignum = 0
    digits.each { |digit| bignum = bignum * from_base + digit }
    converted = []
    until bignum.zero?
      bignum, digit = bignum.divmod to_base
      converted.push digit
    end
    converted.reverse
  end

end

