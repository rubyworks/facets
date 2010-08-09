Covers 'facets/hash/swap'

Case Hash do

  Unit :swap! do
    h = { :a=>1, :b=>2 }
    h.swap!(:a, :b).assert == { :a=>2, :b=>1 }
  end

end

