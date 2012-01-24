covers 'facets/symbol/thrown'

test_case Symbol do

  # TODO: There may be exceptional cases. They must be tested too.
  method :thrown? do
    test do
      assert(:x.thrown? { throw :x })
    end
    test do
      assert(!:x.thrown? { 10 })
    end
  end

end
