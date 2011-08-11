covers 'facets/enumerable/one'

test_case Enumerable do

  method :one? do

    test do
      a = [nil, true]
      assert( a.one? )
    end

    test do
      a = [true, false]
      assert( a.one? )
    end

    test do
      a = [true, true]
      assert( ! a.one? )
    end

    test do
      a = [true, 1]
      assert( ! a.one? )
    end

    test do
      a = [1, 1]
      assert( ! a.one? )
    end

  end

end
