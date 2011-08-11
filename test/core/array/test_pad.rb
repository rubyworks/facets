covers 'facets/array/pad'

test_case Array do

  method :pad do

    test do
      r = [0,1,2,3].pad(7,"x")
      x = [0,1,2,3,"x","x","x"]
      r.assert == x
    end

    test "negative index" do
      r = [0,1,2,3].pad(-7,"n")
      x = ["n","n","n",0,1,2,3]
      r.assert == x
    end

  end

  method :pad! do

    test do
      a = [0,1,2,3]
      r = a.pad!(6,"y")
      x = [0,1,2,3,"y","y"]
      r.assert == x
    end

    test "negative index" do
      a = [0,1,2,3]
      r = a.pad!(-6,"q")
      x = ["q","q",0,1,2,3]
      r.assert == x
    end

  end

end

