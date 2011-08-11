covers 'facets/enumerable/exclude'

test_case Enumerable do

  method :exclude? do

    test do
      a = [1,2,2,3]
      a.refute.exclude?(2)
      a.assert.exclude?(4)
    end

  end

end
