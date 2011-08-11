covers 'facets/array/probability'

test_case Array do

  method :probability do

    test do
      %w{a b}.probability.assert == {'a'=>0.5, 'b'=>0.5}
    end

    test do
      %w{a a a b}.probability.assert == {'a'=>0.75, 'b'=>0.25}
    end

  end

end

