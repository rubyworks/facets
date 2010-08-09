Covers 'facets/symbol/query'

Case Symbol do

  Unit :query? do
    assert( :try?.query? )

    assert( ! :try.query? )
    assert( ! :try=.query? )
  end

end

