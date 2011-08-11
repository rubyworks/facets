covers 'facets/time/change'

test_case Time do

  method :change do

    test do
      t = Time.local(2006,04,20,15,37)
      n = Time.now
      n = n.change(:month=>4, :day=>20, :hour=>15, :min=>37, :year=>2006)
      n.assert == t
    end

  end

end

