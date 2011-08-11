covers 'facets/array/rotate'

test_case Array do

  method :rotate do

    test "clockwise" do
      a = [1,2,3]
      r = a.rotate
      r.assert == [2,3,1]
    end

    test "counter-clockwise" do
      a = [1,2,3]
      r = a.rotate(-1)
      r.assert == [3,1,2]
    end

  end

  method :rotate! do

    test "clockwise" do
      a = [1,2,3]
      a.rotate!
      a.assert == [2,3,1]
    end

    test "counter-clockwise" do
      a = [1,2,3]
      a.rotate!(-1)
      a.assert == [3,1,2]
    end

  end

end

