covers 'facets/array/rotate'

testcase Array do

  unit :rotate => "clockwise" do
    a = [1,2,3]
    r = a.rotate
    r.assert == [2,3,1]
  end

  unit :rotate => "counter-clockwise" do
    a = [1,2,3]
    r = a.rotate(-1)
    r.assert == [3,1,2]
  end

  unit :rotate! => "clockwise" do
    a = [1,2,3]
    a.rotate!
    a.assert == [2,3,1]
  end

  unit :rotate! => "counter-clockwise" do
    a = [1,2,3]
    a.rotate!(-1)
    a.assert == [3,1,2]
  end

end

