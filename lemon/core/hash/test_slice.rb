Covers 'facets/hash/slice'

Case Hash do

  Unit :slice do
    h = {:a=>1,:b=>2,:c=>3}
    h.slice(:a, :b).assert == {:b=>2, :a=>1}
  end

  Unit :slice! do
    h = {:a=>1,:b=>2,:c=>3}
    h.slice!(:a, :b).assert == {:c=>3}
    h.assert == {:a=>1,:b=>2}
  end

end

