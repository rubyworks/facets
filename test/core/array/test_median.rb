covers 'facets/array/median'

test_case Array do

  method :median do
    test "odd sized" do
      r = %w{e a b c d}.median
      r.assert == "c"
    end

    test "even sized" do
      r = %w{f e a b c d}.median
      r.assert == "d"
    end

    test "with positive offset" do
      r = %w{e a b c d}.median(1)
      r.assert == "d"
    end

    test "with negative offset" do
      r = %w{e a b c d}.median(-1)
      r.assert == "b"
    end
  end

end
