covers 'facets/hash/to_mod'

test_case Hash do

  method :to_mod do

    test do
      h = { :a=>1, :b=>2 }
      m = h.to_mod
      Module.assert === m
    end

    test "check methods" do
      h = { :a=>1, :b=>2 }
      m = h.to_mod
      x = Class.new{ include m }.new
      x.a.assert == 1
      x.b.assert == 2
    end

  end

end

