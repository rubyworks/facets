covers 'facets/time/change'

test_case Time do

  method :change do

    test do
      t = Time.local(2006,04,20,15,37)
      n = Time.now
      n = n.change(:month=>4, :day=>20, :hour=>15, :min=>37, :year=>2006)
      n.assert == t
    end

    t = Time.utc(2026, 11, 4, 15, 30, 45, Rational(123456789, 1000))

    test "resets the smaller units" do
      t.change(hour: 1).assert == Time.utc(2026, 11, 4, 1)
      t.change(min: 5).assert == Time.utc(2026, 11, 4, 15, 5)
      t.change(sec: 5).assert == Time.utc(2026, 11, 4, 15, 30, 5)
    end

    test "keeps the smaller units when changing the date" do
      t.change(day: 1).nsec.assert == 123456789
    end

    test "nsec and usec" do
      t.change(nsec: 5).nsec.assert == 5
      t.change(usec: 5).nsec.assert == 5000
      expect(ArgumentError) { t.change(nsec: 5, usec: 5) }
      expect(ArgumentError) { t.change(usec: 1_000_000) }
    end

    test "stays UTC" do
      t.change(hour: 1).assert.utc?
    end

    test "keeps a fixed UTC offset" do
      tz = Time.new(2026, 11, 4, 15, 30, 45, "+09:00")
      tz.change(hour: 1).assert == Time.new(2026, 11, 4, 1, 0, 0, "+09:00")
      tz.change(hour: 1).utc_offset.assert == 9 * 3600
    end

    test "offset gives a new UTC offset" do
      tz = Time.new(2026, 11, 4, 15, 30, 45, "+09:00")
      n = tz.change(offset: "+01:00")
      n.utc_offset.assert == 3600
      n.hour.assert == 15
    end

    test "stays local" do
      l = Time.local(2026, 7, 4, 15, 30)
      n = l.change(day: 5)
      n.assert == Time.local(2026, 7, 5, 15, 30)
      n.refute.utc?
    end

  end

end
