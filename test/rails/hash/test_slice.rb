covers 'facets/hash/slice'

test_case Hash do

  method :slice do

    test 'only existing keys' do
      h = {:a=>1,:b=>2,:c=>3}
      h.slice(:a, :b).assert == {:b=>2, :a=>1}
    end

    test 'with non-existent keys' do
      h = {:a=>1,:b=>2,:c=>3}
      h.slice(:a, :d).assert == {:a=>1}
    end

  end

  method :slice! do

    test do
      h = {:a=>1,:b=>2,:c=>3}
      h.slice!(:a, :b).assert == {:c=>3}
      h.assert == {:a=>1,:b=>2}
    end

    test do
      h = {:a=>1,:b=>2,:c=>3}
      h.slice!(:a, :d).assert == {:c=>3, :b=>2}
      h.assert == {:a=>1}
    end

  end

end

