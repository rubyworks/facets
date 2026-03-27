covers 'facets/range/intersection'

test_case Range do

  class_method :intersection do

    test "two overlapping ranges" do
      Range.intersection(1..10, 5..15).assert == 5..10
    end

    test "three overlapping ranges" do
      Range.intersection(1..5, 3..7, 4..9).assert == 4..5
    end

    test "non-overlapping ranges" do
      Range.intersection(1..3, 5..7).assert == nil
    end

    test "floats" do
      Range.intersection(1.0..5.0, 2.5..4.5).assert == 2.5..4.5
    end

    test "identical ranges" do
      Range.intersection(1..5, 1..5).assert == 1..5
    end

    test "one range contains the other" do
      Range.intersection(1..10, 3..5).assert == 3..5
    end

  end

  method :intersection do

    test "instance method" do
      (1..10).intersection(5..15).assert == 5..10
    end

    test "multiple arguments" do
      (1..10).intersection(5..15, 8..20).assert == 8..10
    end

  end

end
