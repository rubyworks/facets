require 'facets/integer/ordinal'

Case Integer do

  Unit :ordinal do
    1.ordinal.assert == '1st'
    2.ordinal.assert == '2nd'
    3.ordinal.assert == '3rd'
    4.ordinal.assert == '4th'
  end

end

