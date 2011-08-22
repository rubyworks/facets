class Hash

  # Swap the values of a pair of keys in place.
  #
  #   {:a=>1,:b=>2}.swap!(:a,:b)  #=> {:a=>2,:b=>1}
  #
  # CREDIT: Gavin Sinclair

  def swap!(key1, key2)
    tmp = self[key1]
    self[key1] = self[key2]
    self[key2] = tmp
    self
  end

end

