Covers 'facets/array/pad'

TestCase Array do

  Unit :pad do
    r = [0,1,2,3].pad(7,"x")
    x = [0,1,2,3,"x","x","x"]
    r.assert == x
  end

  Unit :pad! do
    a = [0,1,2,3]
    r = a.pad!(6,"y")
    x = [0,1,2,3,"y","y"]
    r.assert == x
  end

  Unit :pad => "negative index" do
    r = [0,1,2,3].pad(-7,"n")
    x = ["n","n","n",0,1,2,3]
    r.assert == x
  end

  Unit :pad! => "negative index" do
    a = [0,1,2,3]
    r = a.pad!(-6,"q")
    x = ["q","q",0,1,2,3]
    r.assert == x
  end

end

