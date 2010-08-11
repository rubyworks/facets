covers 'facets/enumerable/map_send'

tests Enumerable do

  unit :map_send do
    [1,2,3].map_send(:+, 3).assert == [4,5,6]
  end

end

