covers 'facets/symbol/plain'

test_case Symbol do

  method :plain? do

    test do
      assert( :try.plain? )
    end

    test do
      assert( ! :try=.plain? )
      assert( ! :try?.plain? )
    end

  end

end

