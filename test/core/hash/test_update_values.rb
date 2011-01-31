covers 'facets/hash/update_values'

testcase Hash do

  unit :update_values do
    h = {1 => 'A', 2 => 'B'}
    h.update_values{ |v| v.downcase }
    h.assert == {1 => 'a', 2 => 'b'}
  end

end

