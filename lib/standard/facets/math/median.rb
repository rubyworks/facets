require 'facets/math/percentile'

module Math

  # Returns the numerical median for the an array of values;
  # or nil if array is empty.
  #
  def self.median(array)
    percentile(array, 50)
  end

# better definition ?
=begin
  #
  def self.median(array)
    return 0 if array.size == 0

    tmp = array.sort
    mid = tmp.size / 2

    if (tmp.size % 2) == 0
	    (tmp[mid-1] + tmp[mid]).to_f / 2
    else
	    tmp[mid]
    end
  end
=end

end

