covers 'facets/hash/update_values'

test_case Hash do

  method :update_values do

    test do
      h = {1 => 'A', 2 => 'B'}
      h.update_values{ |v| v.downcase }
      h.assert == {1 => 'a', 2 => 'b'}
    end

  end

end
