module Math

  # Calculates the Euclidean Distance between points +p+ and +q+.
  # 
  # `p`, `q` is assumed to described coordinates in N-dimensions, e. g.:
  #
  #    Math.distance([1, 1], [2, 2])          # 2D coordinates
  #    Math.distance([1, 1, 1], [2, 2, 2])    # 3D coordinates
  #
  # If N is 1, then `::distance` may also be invoked like so:
  #
  #    Math.distance(1, 1)  
  #
  def self.distance(p, q)
    p, q = [p].flatten, [q].flatten
    sqrt(p.zip(q).inject(0){ |sum, coord| sum + (coord.first - coord.last)**2 })
  end

end
