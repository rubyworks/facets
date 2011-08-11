covers 'facets/hash/keys'

test_case Hash do

  method :each_with_key do

    test do
      h1 = {:a=>1, :b=>2}
      h2 = {}
      h1.each_with_key { |v,k| h2[v] = k }
      h2.assert == {1=>:a, 2=>:b}
    end

  end

  method :keys? do

    test do
      {:a=>1,:b=>2,:c=>3}.assert.keys?(:a,:b)
      {:a=>1,:b=>2,:c=>3 }.refute.keys?(:a,:b,:d)
    end

  end

  method :only_keys? do

    test do
      {:a=>1,:b=>2,:c=>3}.assert.only_keys?(:a,:b,:c)
      {:a=>1,:b=>2,:c=>3}.refute.only_keys?(:a,:b)
    end

  end

  method :has_keys? do

    test do
      {:a=>1,:b=>2,:c=>3}.assert.has_keys?(:a,:b)
      {:a=>1,:b=>2,:c=>3 }.refute.has_keys?(:a,:b,:d)
    end

  end

  method :has_only_keys? do

    test do
      {:a=>1,:b=>2,:c=>3}.assert.has_only_keys?(:a,:b,:c)
      {:a=>1,:b=>2,:c=>3}.refute.has_only_keys?(:a,:b)
    end

  end

end
