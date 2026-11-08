covers 'facets/time/to_time'

test_case Time do

  method :to_time do

    test do
      t = Time.now
      t.to_time.assert.is_a?(Time)
    end

    test "keeps the UTC offset" do
      t = Time.new(2026, 11, 4, 15, 30, 0, "+09:00")
      t.to_time.utc_offset.assert == 9 * 3600
    end

  end

end
