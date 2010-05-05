Covers 'facets/hash/insert'

Case Hash do

  Unit :insert do
    h = {:a=>1, :b=>2}

    h.assert.insert(:c,3)
    h.assert == {:a=>1, :b=>2, :c=>3}

    h.refute.insert(:a,0)
    h.assert == {:a=>1, :b=>2, :c=>3}
  end

end

