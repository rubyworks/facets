covers 'facets/symbol/query'

test_case Symbol do

  method :query? do

    test do
      assert( :try?.query? )
    end

    test do
      assert( ! :try.query? )
      assert( ! :try=.query? )
    end

  end

end

