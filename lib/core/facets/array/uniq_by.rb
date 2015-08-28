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
  def uniq_by! #:yield:
    h = {}
    replace( inject([]){|a,x| h[yield(x)] ||= a << x} )
  end

end

