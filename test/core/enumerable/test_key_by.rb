covers 'facets/enumerable/key_by'

test_case Enumerable do

  method :key_by do

    test do
      a = [:a,:b,:c]
      r = a.key_by{ |v| v.to_s }
      r.assert == {'a'=>:a, 'b'=>:b, 'c'=>:c}
    end

    # Is this how it should behave?
    test "works with a hash" do
      h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2}
      r = h.key_by{ |k,v| k }
      r.assert == {"A"=>["A",1], "B"=>["B",1], "C"=>["C",1], "D"=>["D",2], "E"=>["E",2]}
    end

  end

end
