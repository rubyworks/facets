class Struct

  # Returns a hash containing the names and values
  # for all instance settings in the Struct.

  def to_h
    h = {}
    each_pair{ |k,v| h[k] = v }
    h
  end

end

