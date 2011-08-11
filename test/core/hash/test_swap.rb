covers 'facets/hash/swap'

test_case Hash do

  method :swap! do

    test do
      h = { :a=>1, :b=>2 }
      h.swap!(:a, :b).assert == { :a=>2, :b=>1 }
    end

  end

end

