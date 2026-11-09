class Range

  # Do two ranges overlap?
  #
  #   (1..5).overlap?(3..8)   #=> true
  #   (1..5).overlap?(6..8)   #=> false
  #
  # Ruby 3.3 added a native Range#overlap?, so only define Facets' version
  # on older Rubies that lack it -- this avoids replacing the built-in.
  # It follows Ruby's own algorithm, so it gives the same answers: an empty
  # range overlaps nothing, beginless and endless ranges work, and a
  # non-Range argument raises TypeError.
  #
  # CREDIT: Daniel Schierbeck, Brandon Keepers

  unless method_defined?(:overlap?)
    def overlap?(other)
      unless other.is_a?(Range)
        raise TypeError, "wrong argument type #{other.class} (expected Range)"
      end

      self_beg, self_end, self_excl = self.begin, self.end, exclude_end?
      other_beg, other_end, other_excl = other.begin, other.end, other.exclude_end?

      # Is the span from b to e empty? Values that can't be compared count
      # as empty, as in Ruby.
      empty = lambda do |b, e, excl|
        next false if b.nil? || e.nil?
        cmp = b <=> e
        cmp.nil? || cmp > 0 || (excl && cmp == 0)
      end

      return false if empty.(self_beg, other_end, other_excl)
      return false if empty.(other_beg, self_end, self_excl)

      if !self_beg.nil? && !other_beg.nil?
        cmp = self_beg <=> other_beg
        return false if cmp.nil?
        return true if cmp == 0
      elsif self_beg.nil? && !self_end.nil? && other_beg.nil? && !other_end.nil?
        return !(self_end <=> other_end).nil?
      end

      return false if empty.(self_beg, self_end, self_excl)
      return false if empty.(other_beg, other_end, other_excl)
      true
    end
  end

end
