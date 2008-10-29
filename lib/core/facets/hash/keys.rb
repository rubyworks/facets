class Hash

  # Returns true or false whether the hash
  # contains the given keys.
  #
  #   h = { :a => 1, :b => 2 }
  #   h.has_keys?( :a )   #=> true
  #   h.has_keys?( :c )   #=> false
  #
  #   CREDIT: Trans

  def has_keys?(*check_keys)
    unknown_keys = check_keys - self.keys
    return unknown_keys.empty?
  end

  alias_method :keys?, :has_keys?

  # Returns true if the hash contains
  # _only_ the given keys, otherwise false.
  #
  #   h = { :a => 1, :b => 2 }
  #   h.has_only_keys?( :a, :b )   #=> true
  #   h.has_only_keys?( :a )       #=> false
  #
  #   CREDIT: Trans

  def has_only_keys?(*check_keys)
    unknown_keys = self.keys - check_keys
    return unknown_keys.empty?
  end

  alias_method :only_keys?, :has_only_keys?

  # Each with key is like each_pair but reverses the order
  # the parameters to [value,key] instead of [key,value].
  #
  #  CREDIT: Trans

  def each_with_key( &yld )
    each_pair{ |k,v| yld.call(v,k) }
  end

end

