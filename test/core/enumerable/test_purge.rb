covers 'facets/enumerable/purge'

tests Enumerable do

  unit :purge do
    [1, nil, 2].purge.assert == [1,2]
  end

  unit :purge => "with trash arguments" do
    (1..6).purge(3,4).assert == [1,2,5,6]
  end

  unit :purge => "with block" do
    (1..6).purge(0){ |n| n % 2 }.assert == [1,3,5]
    (1..6).purge(1){ |n| n % 2 }.assert == [2,4,6]
  end

end
