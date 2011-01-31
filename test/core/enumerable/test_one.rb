covers 'facets/enumerable/one'

testcase Enumerable do

  unit :one? do
    a = [nil, true]
    assert( a.one? )

    a = [true, false]
    assert( a.one? )

    a = [true, true]
    assert( ! a.one? )

    a = [true, 1]
    assert( ! a.one? )

    a = [1, 1]
    assert( ! a.one? )
  end

end
