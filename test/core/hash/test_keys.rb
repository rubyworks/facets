covers 'facets/hash/keys'

test_case Hash do

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
