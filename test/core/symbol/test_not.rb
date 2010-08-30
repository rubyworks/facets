covers 'facets/symbol/not'

testcase Symbol do

  unit :~@ do
    ~:a.assert == :"~a"
  end

  unit :not? do
    a = :a
    n = ~a
    assert( n.not? )
  end

end
