require 'facets/time/to_time'

Case Time do

  Unit :to_time do
    t = Time.now #parse('4/20/2005 15:37')
    t.to_time.assert.is_a?(Time)
  end

end

