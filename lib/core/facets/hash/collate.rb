class Hash

  # Merge the values of this hash with those from another, setting all values
  # to be arrays representing the values from both hashes.
  #
  #   { :a=>1, :b=>2 }.collate(:a=>3, :b=>4, :c=>5)
  #   #=> { :a=>[1,3], :b=>[2,4], :c=>[5] }
  #
  # As of v3.0, this method no longer automatically flattens
  # the array values. To acheive the same effect add a flat map.
  #
  #   h = { :a=>[1,3], :b=>[2,4], :c=>[5] }.collate(:a=>6, :b=>7, :c=>8)
  #   h.each_value{ |v| v.flatten! }
  #   #=> { :a=>[1,3,6], :b=>[2,4,7], :c=>[5,8] }
  #
  # @author Trans         (rewrite)
  # @author Tilo Sloboda  (bug fixes)
  # @author Gavin Kistner (original)

  def collate(*others)
    h = {}
    keys.each do |k|
      h[k] = []
    end
    others.each do |other|
      other.keys.each do |k|
        h[k] = []
      end
    end
    each do |k, v|
      h[k] << v
    end
    others.each do |other|
      other.each do |k, v|
        h[k] << v
      end
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

