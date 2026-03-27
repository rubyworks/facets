covers 'facets/array/to_ranges'

test_case Array do

  method :to_ranges do

    test "flat values" do
      [3,4,5,1,6,9,8].to_ranges.assert == [1..1, 3..6, 8..9]
    end

    test "consecutive" do
      [1,2,3,4,5].to_ranges.assert == [1..5]
    end

    test "mixed ranges and values" do
      [10..15, 16..20, 21, 22].to_ranges.assert == [10..22]
    end

  end

end
