class Range

  # Returns the intersection of two or more ranges — the region they
  # all share. Returns nil if the ranges do not overlap.
  #
  # Works with any comparable type: integers, floats, dates, strings, etc.
  #
  # Examples
  #
  #     Range.intersection(1..10, 5..15)         #=> 5..10
  #     Range.intersection(1..5, 3..7, 4..9)     #=> 4..5
  #     Range.intersection(1..3, 5..7)            #=> nil
  #     Range.intersection(1.0..5.0, 2.5..4.5)   #=> 2.5..4.5
  #
  # Also available as an instance method:
  #
  #     (1..10).intersection(5..15)              #=> 5..10
  #
  # CREDIT: Trans

  def self.intersection(*ranges)
    return nil if ranges.empty?
    ranges.reduce do |result, r|
      return nil unless result.overlap?(r)
      new_first = result.first > r.first ? result.first : r.first
      new_last  = result.last  < r.last  ? result.last  : r.last
      new_first..new_last
    end
  end

  # Returns the intersection of this range with one or more other ranges.
  # Returns nil if the ranges do not overlap.
  #
  #     (1..10).intersection(5..15)        #=> 5..10
  #     (1..10).intersection(5..15, 8..20) #=> 8..10
  #     (1..3).intersection(5..7)          #=> nil
  #
  def intersection(*others)
    Range.intersection(self, *others)
  end

end
