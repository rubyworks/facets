covers 'facets/time/stamp'

testcase Time do

  # TODO: Problem with TIMEZONE.
  omit unit :stamp do
    t = Time.utc(2005,4,20,15,37)
    t.stamp.assert == "Wed Apr 20 15:37:00 PDT 2005"
  end

  unit :stamp => "long format" do
    t = Time.utc(2005,4,20,15,37)
    t.stamp(:long).assert == "April 20, 2005 15:37"
  end

  unit :stamp => "short format" do
    t = Time.utc(2005,4,20,15,37)
    t.stamp(:short).assert == "20 Apr 15:37"
  end

  metaunit :stamp => "long format" do
    Time.stamp(:long)
  end

  metaunit :stamp => "short format" do
    Time.stamp(:short)
  end

end

