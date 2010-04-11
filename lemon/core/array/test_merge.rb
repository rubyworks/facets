require 'facets/array/merge'

TestCase Array do

  Unit :merge do
    a = [1,2,3]
    b = [3,4,5]
    a.merge(b).assert == [1,2,3,4,5]
  end

  Unit :merge! do
    a = [1,2,3]
    b = [3,4,5]
    a.merge!(b)
    a.assert == [1,2,3,4,5]
  end

end

