covers 'facets/time/ago'

test_case Time do

  # We do not need to test #in b/c it is an alias for #shift.
  # One test is provided to add to coverage report.
  method :in do

    test do
      e = Time.utc(2008,11, 1, 18,30,57)
      r = Time.utc(2007,11, 1, 18,30,57).in(1, :years)
      r.assert == e                 
    end

  end

end

