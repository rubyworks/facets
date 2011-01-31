covers 'facets/hash/slice'

testcase Hash do

  unit :slice do
    h = {:a=>1,:b=>2,:c=>3}
    h.slice(:a, :b).assert == {:b=>2, :a=>1}
  end

  unit :slice! do
    h = {:a=>1,:b=>2,:c=>3}
    h.slice!(:a, :b).assert == {:c=>3}
    h.assert == {:a=>1,:b=>2}
  end

end

