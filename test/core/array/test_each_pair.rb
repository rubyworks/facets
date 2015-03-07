covers 'facets/array/each_pair'

test_case Array do

  method :each_pair do

    test do
      result = {}
      a = [:a,:b,:c,:d]
      a.each_pair{|i,e| result[e] = i + 1}
      result.assert == {a: 1, b: 2, c: 3, d: 4}
    end

  end

end
