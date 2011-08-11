covers 'facets/time/to_time'

test_case Time do

  method :to_time do

    test do
      t = Time.now
      t.to_time.assert.is_a?(Time)
    end

  end

end

