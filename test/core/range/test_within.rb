covers 'facets/range/within'

test_case Range do

  method :within? do

    test "wholy within range" do
      assert( (4..5).within?(3..6) )
    end

    test "sentinals are equal" do
      assert( (3..6).within?(3..6) )
    end

    test "lower sentinal out of range" do
      assert(! (2..5).within?(3..6) )
    end

    test "upper sentinal out of range" do
      assert(! (5..7).within?(3..6) )
    end

  end

end
