Covers 'facets/array/stackable.rb'

TestCase Array do

  Unit :poke do
    a = [2,3]
    a.poke(1).assert == [1,2,3]
    a.poke(4).assert == [4,1,2,3]
  end

  Unit :pull do
    a = [1,2,3]
    a.pull.assert == 1
    a.assert == [2,3]
  end

end

