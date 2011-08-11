covers 'facets/hash/traverse'

test_case Hash do

  method :traverse do

    test do
      h = { "A" => "x", "B" => "y" }
      j = h.traverse{ |k,v| [k.downcase, v.upcase] }
      x = { "a" => "X", "b" => "Y" }
      j.refute == h
      j.assert == x
    end

  end

  method :traverse! do

    test do
      h = { "A" => "x", "B" => "y" }
      h.traverse!{ |k,v| [k.downcase, v.upcase] }
      x = { "a" => "X", "b" => "Y" }
      h.assert == x
    end

  end

end

