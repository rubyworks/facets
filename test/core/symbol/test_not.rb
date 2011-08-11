covers 'facets/symbol/not'

test_case Symbol do

  method :~@ do
    test do
      ~:a.assert == :"~a"
    end
  end

  method :not? do
    test do
      a = :a
      n = ~a
      assert( n.not? )
    end
  end

end
