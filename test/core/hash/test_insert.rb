covers 'facets/hash/insert'

test_case Hash do

  method :insert do

    test do
      h = {:a=>1, :b=>2}

      h.assert.insert(:c,3)
      h.assert == {:a=>1, :b=>2, :c=>3}

      h.refute.insert(:a,0)
      h.assert == {:a=>1, :b=>2, :c=>3}
    end

  end

end

