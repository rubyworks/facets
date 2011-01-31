covers 'facets/array/split'

testcase Array do

  unit :split do
    ['a','b','c'].split('b').assert == [['a'], ['c']]
  end

  unit :split => "empty" do
    [].split('a').assert == []
  end

  unit :split => "same" do
    ['a'].split('a').assert == []
  end

end

