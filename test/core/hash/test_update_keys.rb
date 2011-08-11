covers 'facets/hash/update_keys'

test_case Hash do

  method :update_keys do

    test do
      h = { 'A' => 1, 'B' => 2 }
      h.update_keys{ |k| k.downcase }
      h.assert == {'a' => 1, 'b' => 2}
    end

    test do
      h = { :a => 1, :b => 2 }
      h.update_keys{ |k| "#{k}!" }
      h.assert == {'a!' => 1, 'b!' => 2}
    end

  end

end
