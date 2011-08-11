covers 'facets/enumerable/each_with_object'

test_case Enumerable do

  method :each_with_object do

    test do
      r = Hash.new(0)
      a = [1,2,2,3]

      a.each_with_object(r){ |c, h| h[c] += 1 }

      r.assert == { 1=>1, 2=>2, 3=>1 }
    end

  end

end
