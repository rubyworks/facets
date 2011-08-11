covers 'facets/hash/at'

test_case Hash do

  method :at do

    test do
      h = { :a=>1, :b=>2 }
      h.at(:a).assert == 1
      h.at(:b).assert == 2
    end

  end

end

