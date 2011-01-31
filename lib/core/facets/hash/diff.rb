class Hash

  # Difference comparison of two hashes.
  #
  #   h1 = {:a=>1,:b=>2}
  #   h2 = {:a=>1,:b=>3}
  #
  #   h1.diff(h2)  #=> {:b=>2}
  #   h2.diff(h1)  #=> {:b=>3}
  #
  def diff(hash)
    h1 = self.dup.delete_if{ |k,v| hash[k] == v }
    h2 = hash.dup.delete_if{ |k,v| has_key?(k) }
    h1.merge(h2)
  end

end
