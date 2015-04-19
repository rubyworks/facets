class Array

  # Convert an associative array to a Hash.
  #
  # Examples
  #
  #   [[:a, 1], [:b, 2]].to_h
  #   #=> {:a=>1, :b=>2}
  #
  # Returns [Hash].
  #
  def to_h
    h = {}
    each{ |(k,v)| h[k] = v }
    h
  end unless method_defined?(:to_h)

end

