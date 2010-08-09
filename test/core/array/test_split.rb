Covers 'facets/array/split'

Case Array do

  Unit :split do
    ['a','b','c'].split('b').assert == [['a'], ['c']]
  end

  Unit :split => "empty" do
    [].split('a').assert == []
  end

  Unit :split => "same" do
    ['a'].split('a').assert == []
  end

end

