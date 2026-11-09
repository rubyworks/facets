covers 'facets/range/overlap'

test_case Range do

  method :overlap? do

    test "true when two ranges share elements" do
      (1..5).overlap?(3..8).assert == true
    end

    test "false when two ranges are disjoint" do
      (1..5).overlap?(6..8).assert == false
    end

    test "true when ranges touch at a boundary" do
      (1..5).overlap?(5..9).assert == true
    end

    test "true when one range contains the other" do
      (1..10).overlap?(3..5).assert == true
    end

    test "false when an exclusive end only touches the other range" do
      (1...5).overlap?(5..9).assert == false
    end

    test "false when either range is empty" do
      (1..5).overlap?(3...3).assert == false
      (3...3).overlap?(1..5).assert == false
      (1..5).overlap?(5..1).assert == false
    end

    test "handles beginless and endless ranges" do
      (3..).overlap?(..5).assert == true
      (..5).overlap?(3..).assert == true
      (..5).overlap?(6..).assert == false
      (3..).overlap?(1..2).assert == false
    end

    test "raises TypeError when given something other than a range" do
      TypeError.assert.raised? { (1..5).overlap?(3) }
    end

  end

end
