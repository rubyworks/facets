covers 'facets/enumerable/each_with_object'

tests Enumerable do

  unit :each_with_object do
    r = Hash.new(0)
    a = [1,2,2,3]

    a.each_with_object(r){ |c, h| h[c] += 1 }

    r.assert == { 1=>1, 2=>2, 3=>1 }
  end

end
