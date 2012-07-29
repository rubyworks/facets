class Array

  # Convert an associative array to a Hash.
  #
  #   [[:a, 1], [:b, 2]].to_h
  #   #=> {:a=>1, :b=>2}
  #
  #   [[:a, 1], :b].to_h
  #   #=> {:a=>1, :b=>nil}
  #
  def to_h
    h = {}
    each{ |(k,v)| h[k] = v }
    h
  end

end

