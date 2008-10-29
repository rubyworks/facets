class Hash

  # Difference comparison of two hashes.

  def diff(hash)
    h1 = self.dup.delete_if{ |k,v| hash[k] == v }
    h2 = hash.dup.delete_if{ |k,v| has_key?(k) }
    h1.merge(h2)
  end

end
