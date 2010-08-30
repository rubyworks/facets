covers 'facets/symbol/plain'

testcase Symbol do

  unit :plain? do
    assert( :try.plain? )

    assert( ! :try=.plain? )
    assert( ! :try?.plain? )
  end

end

