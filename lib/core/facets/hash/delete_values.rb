class Hash

  # Minor modification to Ruby's Hash#delete method
  # allowing it to take multiple keys.
  #
  #   hsh = { :a => 1, :b => 2 }
  #   hsh.delete_values(1)
  #   hsh  #=> { :b => 2 }
  #
  # CREDIT: Daniel Schierbeck

  def delete_values(*values)
    keys.map{ |key| delete(key) if values.include?(fetch(key)) }
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
