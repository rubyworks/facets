class Struct

  # Returns a hash containing the names and values
  # for all instance settings in the Struct.
  #
  # This will eventually be deprecated in favor of #to_h.

  def attributes
    h = {}
    each_pair { |k,v| h[k] = v }
    h
  end

end

