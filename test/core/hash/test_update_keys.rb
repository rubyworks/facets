covers 'facets/hash/update_keys'

testcase Hash do

  unit :update_keys do
    h = { 'A' => 1, 'B' => 2 }
    h.update_keys{ |k| k.downcase }
    h.assert == {'a' => 1, 'b' => 2}
  end

  unit :update_keys do
    h = { :a => 1, :b => 2 }
    h.update_keys{ |k| "#{k}!" }
    h.assert == {'a!' => 1, 'b!' => 2}
  end

end
