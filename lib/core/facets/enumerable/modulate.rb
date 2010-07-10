module Enumerable

  # Modulate. Divide an array into groups by modulo of the index.
  #
  #   [2,4,6,8].modulate(2)  #=> [[2,6],[4,8]]
  #
  # CREDIT: Trans
  #
  # NOTE: Would the better name for this be 'collate'?

  def modulate(modulo)
    return to_a if modulo == 1
    raise ArgumentError, 'bad modulo' if size % modulo != 0
    r = Array.new(modulo, [])
    (0...size).each do |i|
      r[i % modulo] += [self[i]]
    end
    r
  end

end

