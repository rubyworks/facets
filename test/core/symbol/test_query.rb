covers 'facets/symbol/query'

testcase Symbol do

  unit :query? do
    assert( :try?.query? )

    assert( ! :try.query? )
    assert( ! :try=.query? )
  end

end

