class Array

  # Produces an array of ranges from the values in the array.
  # Contiguous values and overlapping ranges are merged.
  #
  # Examples
  #
  #     [1,2,3,6,7,8].to_ranges  #=> [1..3, 6..8]
  #
  #     [3,4,5,1,6,9,8].to_ranges  #=> [1..6, 8..9]
  #
  #     [10..15, 16..20, 21, 22].to_ranges  #=> [10..22]
  #
  # Assumes inclusive ranges (i.e. 1..4) and range.first <= range.last.
  #
  # Works with integers, dates and strings. However, all the objects
  # in the array must be of the same class.
  #
  # CREDIT: monocle, Ryan Duryea

  def to_ranges
    array = compact.uniq.sort_by { |e| Range === e ? e.first : e }
    array.inject([]) do |c, value|
      unless c.empty?
        last = c.last
        last_value    = (Range === last  ? last.last   : last)
        current_value = (Range === value ? value.first : value)
        if (last_value.succ <=> current_value) == -1
          c << value
        else
          first  = (Range === last ? last.first : last)
          second = [Range === last ? last.last : last, Range === value ? value.last : value].max
          c[-1] = [first..second]
          c.flatten!
        end
      else
        c << value
      end
    end
  end

  alias arrange to_ranges
  alias rangify to_ranges

end
