class Hash

  # Returns a new hash created by traversing the hash and its subhashes,
  # executing the given block on the key and value. The block should
  # return a 2-element array of the form +[key, value]+.
  #
  #   h = { "A"=>"A", "B"=>"B", { "X"=>"X" } }
  #
  #   g = h.recursive_map{ |k,v| [k.downcase, v] }
  #
  #   g  #=> [["a", "A"], ["b", "B"], [["x", "X"]]]
  #
  # CREDIT: Trans

  def recursive_map(&block)
    inject([]) do |a,(k,v)|
      if Hash === v
        v = v.recursive_map(&block)
      elsif v.respond_to?(:to_hash)
        v = v.to_hash.recursive_map(&block)
      end
      nk, nv = block.call(k,v)
      a << [nk, nv]
      a
    end
  end

  # In-place rendition of #recursive_map.

  def recursive_map!(&b)
    replace(recursive_map(&b))
  end

end

