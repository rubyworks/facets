covers 'facets/hash/keys'

tests Hash do

  unit :each_with_key do
    h1 = {:a=>1, :b=>2}
    h2 = {}
    h1.each_with_key { |v,k| h2[v] = k }
    h2.assert == {1=>:a, 2=>:b}
  end

  unit :keys? do
    {:a=>1,:b=>2,:c=>3}.assert.keys?(:a,:b)
    {:a=>1,:b=>2,:c=>3 }.refute.keys?(:a,:b,:d)
  end

  unit :only_keys? do
    {:a=>1,:b=>2,:c=>3}.assert.only_keys?(:a,:b,:c)
    {:a=>1,:b=>2,:c=>3}.refute.only_keys?(:a,:b)
  end

  unit :has_keys? do
    {:a=>1,:b=>2,:c=>3}.assert.has_keys?(:a,:b)
    {:a=>1,:b=>2,:c=>3 }.refute.has_keys?(:a,:b,:d)
  end

  unit :has_only_keys? do
    {:a=>1,:b=>2,:c=>3}.assert.has_only_keys?(:a,:b,:c)
    {:a=>1,:b=>2,:c=>3}.refute.has_only_keys?(:a,:b)
  end

end

