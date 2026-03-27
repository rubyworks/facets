class Struct

  # Returns a hash containing the names and values
  # for all instance settings in the Struct.
  #
  # This will eventually be deprecated in favor of #to_h.

  def attributes
    warn "Struct#attributes is deprecated. Use Struct#to_h instead.", uplevel: 1
    to_h
  end

end

