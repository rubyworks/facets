class Hash

  # Creates a new hash from two separate arrays, a +keys+ array and
  # a +values+ array.
  #
  #   Hash.zip(["a","b","c"], [1,2,3])
  #   # => { "a"=>1, "b"=>2, "c"=>3 }
  #
  # CREDIT: Trans, Ara T. Howard

  def self.zip(keys,values) # or some better name
    h = {}
    keys.size.times{ |i| h[ keys[i] ] = values[i] }
    h
  end

end

