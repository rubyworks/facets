module Enumerable

  # Conver enumerable into a Hash, iterating
  # over each member where the provided block
  # must return the key to by used to map to 
  # the value.
  #
  # Examples:
  #
  #   [:a,:b,:c].key_by{ |v| v.to_s }
  #   #=> {'a'=>:a, 'b'=>:b, 'c'=>:c}
  #
  # Returns: Hash

  def key_by
    return to_enum(:key_by) unless block_given?

    h = []
    each do |v|
      h[yield(v)] = v
    end
    h
  end

end
