class Hash
  # Recursively converts a Hash object to an OpenStruct object.
  #
  # Returns a copy of the hash as an OpenStruct.
  def to_ostruct()
    struct = OpenStruct.new(self.clone())
    each do |k, v|
      struct.__send__("#{k}=", v.to_ostruct()) if v.is_a?(Hash)
      struct.__send__(k).map! {|x| x.is_a?(Hash) ? x.to_ostruct() : x} if v.is_a?(Array)
    end
    return struct
  end
end

