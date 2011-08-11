covers 'facets/time/stamp'

test_case Time do

  method :stamp do

    # TODO: Problem with TIMEZONE.
    test "timezone" do
      t = Time.utc(2005,4,20,15,37)
      t.stamp.assert == "Wed Apr 20 15:37:00 UTC 2005"
    end

    test "long format" do
      t = Time.utc(2005,4,20,15,37)
      t.stamp(:long).assert == "April 20, 2005 15:37"
    end

    test "short format" do
      t = Time.utc(2005,4,20,15,37)
      t.stamp(:short).assert == "20 Apr 15:37"
    end

  end

  class_method :stamp do

    test "long format" do
      Time.stamp(:long)
    end

    test "short format" do
      Time.stamp(:short)
    end

  end

end

