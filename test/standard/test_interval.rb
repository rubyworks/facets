covers 'facets/interval'

test_case Interval do

  method :step do

    test "yields each step" do
      a = []
      Interval[0,10].step(5){ |x| a << x }
      a.assert == [0, 5, 10]
    end

    test "without a block returns an enumerator" do
      e = Interval[0,10].step(5)
      e.assert.is_a?(Enumerator)
      e.to_a.assert == [0, 5, 10]
    end

  end

end
