class Hash

  # Merge the values of this hash with those from another, setting all values
  # to be arrays representing the values from both hashes.
  #
  #   { :a=>1, :b=>2 }.collate(:a=>3, :b=>4, :c=>5)
  #   #=> { :a=>[1,3], :b=>[2,4], :c=>[5] }
  #
  # CREDIT: Tilo Sloboda, Gavin Kistner (Phrogz)

  def collate(other)
    h = Hash.new
    (keys + other.keys).each do |key|
      h[key] = []
    end
    each do |key, value|
      h[key] << value
    end
    other.each do |key, value|
      h[key] << value
    end
    h.each{ |k,v| v.flatten! }
    h
  end

  # The same as #collate, but modifies the receiver in place.
  def collate!(other_hash)
    result = collate(other_hash)
    replace(result)
  end

  # Old version ...
  #
  #  def collate!(other_hash)
  #    # Prepare, ensuring every existing key is already an Array
  #    each do |key, value|
  #      if value.is_a?(Array)
  #        self[key] = value
  #      else
  #        self[key] = [value]
  #      end
  #    end
  #    # Collate with values from other_hash
  #    other_hash.each do |key, value|
  #      if self[key]
  #        if value.is_a?(Array)
  #          self[key].concat( value )
  #        else
  #          self[key] << value
  #        end
  #      elsif value.is_a?(Array)
  #        self[key] = value
  #      else
  #        self[key] = [value]
  #      end
  #    end
  #    #each{ |key, value| value.uniq! } if options[ :uniq ]
  #    self
  #  end

end

