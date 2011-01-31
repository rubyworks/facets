covers 'facets/integer/ordinal'

testcase Integer do

  unit :ordinal do
    1.ordinal.assert == '1st'
    2.ordinal.assert == '2nd'
    3.ordinal.assert == '3rd'
    4.ordinal.assert == '4th'
  end

  unit :ordinalize do
    1.ordinalize.assert == '1st'
    2.ordinalize.assert == '2nd'
    3.ordinalize.assert == '3rd'
    4.ordinalize.assert == '4th'
  end

end

