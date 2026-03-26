class Array

  # Convert an array of values (which must respond to #succ) to an
  # array of ranges.
  #
  #   [3,4,5,1,6,9,8].to_ranges => [1..1,3..6,8..9]
  #
  # CREDIT: Adapted and debugged by Ryan Duryea
  # from https://dzone.com/articles/convert-ruby-array-ranges

  def to_ranges
    array = self.compact.uniq.sort
    ranges = []
    if !array.empty?
      # Initialize the left and right endpoints of the range
      left, right = array.first, nil
      array.each do |obj|
        # If the right endpoint is set and obj is not equal to right's successor
        # then we need to create a range.
        if right && obj != right.succ
          ranges << Range.new(left,right)
          left = obj
        end
        right = obj
      end
      ranges << Range.new(left,right)
    end
    ranges
  end
end
