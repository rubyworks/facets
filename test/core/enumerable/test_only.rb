covers 'facets/enumerable/only'

test_case Enumerable do

  method :only? do

    test do
      assert( [false].only? )
      assert( [1].only? )
      assert( ![false, false].only? )
      assert( ![].only? )
    end  

  end

end
