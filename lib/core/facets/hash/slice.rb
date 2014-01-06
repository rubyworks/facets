class Hash

  # Returns a new hash with only the given keys.
  #
  #   h = {:a=>1, :b=>2, :c=>3}
  #   h.slice(:a, :c)  #=> {:a=>1, :c=>3}
  #   h.slice(:a, :d)  #=> {:a=>1}
  #
  def slice(*keep_keys)
    if block_given?
      each do |k, v|
        keep_keys << k if yield(k, v)
      end
    end

    hash = {}
    keep_keys.each do |key|
      hash[key] = fetch(key) if key?(key)
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
    if block_given?
      each do |k, v|
        keep_keys << k if yield(k, v)
      end
    end

    rejected = keys - keep_keys
    removed = {}
    rejected.each{ |k| removed[k] = delete(k) }
    removed
  end

end

# NOTE: ActiveSupport defines this method but adds a check for #convert_key.
#       If the method is defined, then it converts the keys with it. However
#       it doesn't look to be supported by all Hash methods, just
#       HashWithIndifferentAccess. I'm not so sure support for this kind of
#       thing is appropriate for Facets.

