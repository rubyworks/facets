covers 'facets/time/to_time'

testcase Time do

  unit :to_time do
    t = Time.now
    t.to_time.assert.is_a?(Time)
  end

end

