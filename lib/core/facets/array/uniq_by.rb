class Array

  # Like #uniq, but determines uniqueness based on a given block.
  #
  #   a = (-5..5).to_a
  #   a.uniq_by!{ |i| i*i }
  #   a #=> [-5, -4, -3, -2, -1, 0]
  #
  # As can be seen in the example, order is significant.
  def uniq_by! #:yield:
    h = {}
    replace( inject([]){|a,x| h[yield(x)] ||= a << x} )
  end

end

