# = TITLE:
#   Roman Numerals
#
# = SYNOPSIS:
#   Generates roman numerals from integers and vice-versa.
#
# = NOTES:
#   A response to Ruby Quiz of the Week #22 - Roman Numerals [ruby-talk:132925]
#
# = AUTHORS:
#   - Dave Burt <dave at burt.id.au>
#   - Trans

module English #:nodoc:

# Contains methods to convert integers to roman numeral strings and vice-versa.

module RomanNumerals

  # The largest integer representable as a roman
  # numerable by this module.

  MAX = 3999

  # Stolen from O'Reilly's Perl Cookbook 6.23. Regular Expression Grabbag.

  REGEXP = /^M*(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])$/i

  #

  SYMBOLS = [  "M", "D", "C", "L", "X", "V", "I" ]
  NUMBERS = [ 1000, 500, 100,  50,  10,   5,   1 ]


  # Maps roman numeral digits to their integer values.
  #   {
  #     'I' => 1,
  #     'V' => 5,
  #     'X' => 10,
  #     'L' => 50,
  #     'C' => 100,
  #     'D' => 500,
  #     'M' => 1000,
  #   }

  TABLE = Hash[*SYMBOLS.zip(NUMBERS).flatten]

  #

  PAIR_SYMBOLS = [ "CM", "CD", "XC", "XL", "IX", "IV", "I" ]
  PAIR_NUMBERS = [ 900,  400,    90,   40,    9,    4,   1 ]

  #   {
  #     'CM' => 900,
  #     'CD' => 400,
  #     'XC' => 90,
  #     'XL' => 40,
  #     'IX' => 9,
  #     'IV' => 4
  #   }

  PAIR_TABLE  = Hash[*PAIR_SYMBOLS.zip(PAIR_NUMBERS).flatten]

  #

  LOOKUP = TABLE.invert.merge(PAIR_TABLE.invert)


  class << self

  # Converts +integer+ to a roman numeral.

  def from_integer(integer)
    return nil if integer < 0 || integer > MAX

    r = integer  # remainder
    y = ''       # result

    NUMBERS.each do |n|
      while r >= n
        r -= n
        y += LOOKUP[n]
      end
      break if r <= 0
    end

    return y
  end

  alias_method :roman, :from_integer

  # Converts +roman_string+, a roman numeral, to an integer

  def to_integer(roman_string)
    return nil unless roman_string.is_roman_numeral?

    l = nil  # last
    i = 0    # integer result

    c = roman_string.to_s.upcase.split(//).reverse

    c.each do |d|
      if v = TABLE[d]
        if l && l > v
          i -= v
        else
          i += v
        end
        l = v
      end
    end

    return i
  end

  alias_method :arabic, :to_integer

  # Returns true iif +string+ is a roman numeral.

  def is_roman_numeral?(string)
    REGEXP =~ string
  end

  end

end

end # module English


class Integer

  def roman
    English::RomanNumerals.roman(self) || ''
  end

  # Converts this integer to a roman numeral.

  def to_s_roman
    English::RomanNumerals.from_integer(self) || ''
  end

end


class String

  # Considers string a roman numeral numeral,
  # and converts it to the corresponding integer.

  def to_i_roman
    English::RomanNumerals.to_integer(self)
  end

  # Returns true iif the subject is a roman numeral.

  def is_roman_numeral?
    English::RomanNumerals.is_roman_numeral?(self)
  end

end


# # Quiz solution: filter that swaps roman and arabic numbers
# if __FILE__ == $0
#   ARGF.each do |line|
#     line.chomp!
#     if line.is_roman_numeral?
#       puts line.to_i_roman
#     else
#       puts line.to_i.to_s_roman
#     end
#   end
# end
