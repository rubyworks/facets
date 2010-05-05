Covers 'facets/hash/update_values'

Case Hash do

  Unit :update_values do
    h = {1 => 'A', 2 => 'B'}
    h.update_values{ |v| v.downcase }
    h.assert == {1 => 'a', 2 => 'b'}
  end

end

