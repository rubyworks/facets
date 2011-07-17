class Hash

  # Minor modification to Ruby's Hash#delete method
  # allowing it to take multiple keys.
  #
  #   hsh = { :a => 1, :b => 2 }
  #   hsh.delete_values(1)
  #   hsh  #=> { :b => 2 }
  #
  # Returns a list of keys of the deleted entries.
  #
  # CREDIT: Daniel Schierbeck

  def delete_values(*values)
    deleted_keys = []
    keys.each do |key|
      if values.include?(fetch(key))
        deleted_keys << key
        delete(key)
      end
    end
    deleted_keys
  end

  # Minor modification to Ruby's Hash#delete method
  # allowing it to take multiple keys.
  #
  #    hsh = {:a=>1, :b=>2, :c=>3}
  #
  #    a, b, c = hsh.delete_values_at(:a, :b, :c)
  #
  #    [a, b, c]  #=> [1, 2, 3]
  #    hsh        #=> {}
  #
  # CREDIT: Daniel Schierbeck

  def delete_values_at(*keys, &yld)
    keys.map{|key| delete(key, &yld) }
  end

end
