class Hash

  # Same as Hash#merge but recursively merges sub-hashes.

  def deep_merge(other)
    hash = self.dup
    other.each do |key, value|
      myval = self[key]
      if value.is_a?(Hash) && myval.is_a?(Hash)
        hash[key] = myval.deep_merge(value)
      else
        hash[key] = value
      end
    end
    hash
  end

  # Same as Hash#merge! but recursively merges sub-hashes.

  def deep_merge!(other)
    other.each do |key, value|
      myval = self[key]
      if value.is_a?(Hash) && myval.is_a?(Hash)
        myval.deep_merge!(value)
      else
        self[key] = value
      end
    end
    self
  end

end

