covers 'facets/time/dst_adjustment'

test_case Time do

  # TODO: Is Time#dst_adjustment test correct?
  method :dst_adjustment do
    test do
      t0 = Time.utc(2010,01,20,12,00,00)
      t1 = Time.utc(2010,06,20,12,00,00)

      tt = t1.dst_adjustment(t0)
      tt.assert == t0

      tt = t0.dst_adjustment(t1)
      tt.assert == t1
    end
  end

end
