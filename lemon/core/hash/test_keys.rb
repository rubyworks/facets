Covers 'facets/hash/keys'

Case Hash do

  Unit :each_with_key do
    h1 = {:a=>1, :b=>2}
    h2 = {}
    h1.each_with_key { |v,k| h2[v] = k }
    h2.assert == {1=>:a, 2=>:b}
  end

  Unit :has_keys? do
    {:a=>1,:b=>2,:c=>3}.assert.has_keys?(:a,:b)
    {:a=>1,:b=>2,:c=>3 }.refute.has_keys?(:a,:b,:d)
  end

  Unit :has_only_keys? do
    {:a=>1,:b=>2,:c=>3}.assert.has_only_keys?(:a,:b,:c)
    {:a=>1,:b=>2,:c=>3}.refute.has_only_keys?(:a,:b)
  end

end

