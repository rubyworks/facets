covers 'facets/symbol/setter'

testcase Symbol do

  unit :setter? do
    assert( :try=.setter? )

    assert( ! :try.setter? )
    assert( ! :try?.setter? )
  end

end

