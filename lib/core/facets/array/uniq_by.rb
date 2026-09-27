class Array

  # Like #uniq, but determines uniqueness based on a given block.
  # As can be seen in the following examples, order is significant.
  #
  # Examples
  #
  #   a = (-5..5).to_a
  #   a.uniq_by!{ |i| i*i }
  #   a #=> [-5, -4, -3, -2, -1, 0]
  #
  #   a = (-5..5).to_a.reverse
  #   a.uniq_by!{ |i| i*i }
  #   a #=> [5, 4, 3, 2, 1, 0]
  #
  # Returns [Array] of unique elements.
  #
  # @deprecated Use Array#uniq! with a block instead (Ruby 1.9.2+).
  #   Scheduled for removal after 2027-09-30.
  #
  def uniq_by!(&block) #:yield:
    warn "Array#uniq_by! is deprecated. Use Array#uniq!(&block) instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    uniq!(&block)
  end

end

