covers 'facets/enumerable/none'

test_case Enumerable do

  method :none? do

    test do
      a = [nil, nil]
      assert( a.none? )
    end

    test do
      a = [false, false]
      assert( a.none? )
    end

    test do
      a = [true, false]
      assert( ! a.none? )
    end

    test do
      a = [nil, 1]
      assert( ! a.none? )
    end

  end

end
