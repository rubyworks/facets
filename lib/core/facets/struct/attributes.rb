class Struct

  # Returns a hash containing the names and values for all instance variables in the Struct.
  def attributes
    h = {}
    each_pair { |k,v| h[k] = v }
    h
  end

end # class Struct

