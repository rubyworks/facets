covers 'facets/comparable/cmp'

tests Comparable do

  unit :cmp => 'on integers' do
    3.cmp(4).assert == -1
    3.cmp(3).assert ==  0
    3.cmp(2).assert ==  1
  end

end

