Covers 'facets/symbol/not'

Case Symbol do

  Unit :~@ do
    ~:a.assert == :"~a"
  end

  Unit :not? do
    a = :a
    n = ~a
    assert( n.not? )
  end

end
