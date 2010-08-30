covers 'facets/hash/swap'

testcase Hash do

  unit :swap! do
    h = { :a=>1, :b=>2 }
    h.swap!(:a, :b).assert == { :a=>2, :b=>1 }
  end

end

