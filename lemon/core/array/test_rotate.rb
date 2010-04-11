require 'facets/array/rotate'

TestCase Array do

  Unit :rotate => "clockwise" do
    a = [1,2,3]
    r = a.rotate
    r.assert == [3,1,2]
  end

  Unit :rotate => "counter-clockwise" do
    a = [1,2,3]
    r = a.rotate(-1)
    r.assert == [2,3,1]
  end

  Unit :rotate! => "clockwise" do
    a = [1,2,3]
    a.rotate!
    a.assert == [3,1,2]
  end

  Unit :rotate! => "counter-clockwise" do
    a = [1,2,3]
    a.rotate!(-1)
    a.assert == [2,3,1]
  end

end

