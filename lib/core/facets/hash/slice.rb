class Hash

  # Returns a new hash with only the given keys.
  #
  #   h = {:a=>1, :b=>2}
  #   h.slice(:a)  #=> {:a=>1}
  #
  def slice(*keep_keys)
    hash = {}
    keep_keys.each do |key|
      hash[key] = fetch(key)
    end
    hash
  end

  # Replaces hash with a new hash having only the given keys.
  # This return the hash of keys removed.
  #
  #   h = {:a=>1, :b=>2}
  #   h.slice!(:a)  #=> {:b=>2}
  #   h             #=> {:a=>1}
  #
  # Returns a Hash of the removed pairs.
  def slice!(*keep_keys)
    rejected = keys - keep_keys
    removed = {}
    rejected.each{ |k| removed[k] = delete(k) }
    removed
  end

end

