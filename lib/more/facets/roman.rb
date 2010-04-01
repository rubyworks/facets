class Integer

  #
  ROMAN_MAX = 3999

  #
  ROMAN_VALUES = [
    ["M", 1000],
    ["CM", 900],
    ["D",  500],
    ["CD", 400],
    ["C",  100],
    ["XC",  90],
    ["L",   50],
    ["XL",  40],
    ["X",   10],
    ["IX",   9],
    ["V",    5],
    ["IV",   4],
    ["I",    1]
  ]

  # Converts this integer to a roman numeral.
  def roman
    int = self
    #return nil if integer > ROMAN_MAX
    return "-#{(-int).roman}" if int < 0
    return "" if int == 0
    ROMAN_VALUES.each do |(i, v)|
      return(i + (int-v).roman) if v <= int 
    end
  end

end


class String

  # Taken from O'Reilly's Perl Cookbook 6.23. Regular Expression Grabbag.
  ROMAN = /^M*(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])$/i

  #
  ROMAN_VALUES = Integer::ROMAN_VALUES.inject({}){ |h,(r,a)| h[r] = a; h }

  # Considers string a Roman numeral numeral,
  # and converts it to the corresponding integer.
  def roman
    roman = self
    raise unless roman?
    last = roman[-1,1]
    roman.reverse.split('').inject(0) do |result, c|
      if ROMAN_VALUES[c] < ROMAN_VALUES[last]
        result -= ROMAN_VALUES[c]
      else
        last = c
        result += ROMAN_VALUES[c]
      end
    end
  end

  # Returns true iif the subject is a valid Roman numeral.
  def roman?
    ROMAN =~ self
  end

end

