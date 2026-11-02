module Math

  # Returns the percentile value for percentile _pcnt_; nil if array is empty.
  #
  # +pcnt+ should be expressed as an integer, e.g. `percentile(90)` returns
  # the 90th percentile of the array.
  #
  # Algorithm from NIST[http://www.itl.nist.gov/div898/handbook/prc/section2/prc262.htm]
  #
  # NOTE: This is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Ben Koski
  #
  # @non-core
  #   require 'facets/math/percentile'
  #
  def self.percentile(array, pcnt)
    return nil if array.length == 0

    sorted_array = array.sort

    rank  = (pcnt.to_f / 100) * (array.length + 1)
    whole = rank.truncate

    # A rank below 1 or past the last value is clamped to the minimum or
    # maximum, as NIST specifies.
    return sorted_array.first if whole < 1
    return sorted_array.last  if whole >= array.length

    # if has fractional part
    if whole != rank
      s0 = sorted_array[whole - 1]
      s1 = sorted_array[whole]

      f = rank - whole

      return (f * (s1 - s0)) + s0
    else
      return sorted_array[whole - 1]
    end
  end
  
end

