covers "facets/hash/diff"

test_case Hash do

  method :diff do

    test do
      h1 = {:a=>1,:b=>2}
      h2 = {:a=>1,:b=>3}
      h1.diff(h2).assert == {:b=>2}
      h2.diff(h1).assert == {:b=>3}
    end

  end

end
