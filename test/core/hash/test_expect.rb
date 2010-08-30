covers 'facets/hash/except'

testcase Hash do

  unit :except do
    h = {:a=>1, :b=>2, :c=>3}
    h.except(:a).assert == {:b=>2,:c=>3}
  end

  unit :except! do
    h = {:a=>1, :b=>2, :c=>3}
    h.except!(:a).assert == {:a=>1}
    h.assert == {:b=>2,:c=>3}
  end

end
