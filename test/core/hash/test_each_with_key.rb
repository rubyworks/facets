covers 'facets/hash/each_with_key'

test_case Hash do

  method :each_with_key do

    test do
      h1 = {:a=>1, :b=>2}
      h2 = {}
      h1.each_with_key { |v,k| h2[v] = k }
      h2.assert == {1=>:a, 2=>:b}
    end

  end

end
