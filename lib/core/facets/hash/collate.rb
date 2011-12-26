class Hash

  # Merge the values of this hash with those from another, setting all values
  # to be arrays representing the values from both hashes.
  #
  #   { :a=>1, :b=>2 }.collate(:a=>3, :b=>4, :c=>5)
  #   #=> { :a=>[1,3], :b=>[2,4], :c=>[5] }
  #
  # @author Trans         (rewrite)
  # @author Tilo Sloboda  (bug fixes)
  # @author Gavin Kistner (original)

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

end

