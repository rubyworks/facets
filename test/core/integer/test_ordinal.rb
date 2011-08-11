covers 'facets/integer/ordinal'

test_case Integer do

  method :ordinal do

    test do
      1.ordinal.assert == '1st'
      2.ordinal.assert == '2nd'
      3.ordinal.assert == '3rd'
      4.ordinal.assert == '4th'
    end

  end

  method :ordinalize do

    test do
      1.ordinalize.assert == '1st'
      2.ordinalize.assert == '2nd'
      3.ordinalize.assert == '3rd'
      4.ordinalize.assert == '4th'
    end

  end

end
