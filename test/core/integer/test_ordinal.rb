covers 'facets/integer/ordinal'

test_case Integer do

  method :ordinal do

    test do
      1.ordinal.assert == '1st'
      2.ordinal.assert == '2nd'
      3.ordinal.assert == '3rd'
      4.ordinal.assert == '4th'
    end


    test "teens" do
      [11, 12, 13, 111, 112, 113].map(&:ordinal).assert == %w[11th 12th 13th 111th 112th 113th]
    end

    test "after the teens" do
      [21, 22, 23, 101, 102, 1003].map(&:ordinal).assert == %w[21st 22nd 23rd 101st 102nd 1003rd]
    end

    test "negative numbers" do
      [-1, -2, -3, -11, -21, -1021].map(&:ordinal).assert == %w[-1st -2nd -3rd -11th -21st -1021st]
    end

  end

  method :ordinalize do

    test do
      1.ordinalize.assert == '1st'
      2.ordinalize.assert == '2nd'
      3.ordinalize.assert == '3rd'
      4.ordinalize.assert == '4th'
    end


    test "negative numbers" do
      -1.ordinalize.assert == '-1st'
    end

  end

end
