class Hash

  # Returns a new hash created by traversing the hash and its subhashes,
  # executing the given block on the key and value. The block should
  # return a 2-element array of the form +[key, value]+.
  #
  #   h = {"A"=>"A", "B"=>"B", "C"=>{"X"=>"X"}}
  #
  #   g = h.traverse{ |k,v| [k.downcase, v] }
  #
  #   g  #=> {"a"=>"A", "b"=>"B", "c"=>{"x"=>"X"}}
  #
  # NOTE: Hash#traverse is the same as `recursive.graph` and
  # might be deprecated in the future (if it ever works!)
  #
  # CREDIT: Trans

  def traverse(&block)
    inject({}) do |h,(k,v)|
      if Hash === v
        v = v.traverse(&block)
      elsif v.respond_to?(:to_hash)
        v = v.to_hash.traverse(&block)
      end
      nk, nv = block.call(k,v)
      h[nk] = nv
      h
    end
  end

  # In place version of traverse, which traverses the hash and its
  # subhashes, executing the given block on the key and value.
  #
  #   h = { "A"=>"A", "B"=>"B" }
  #
  #   h.traverse!{ |k,v| [k.downcase, v] }
  #
  #   h  #=> { "a"=>"A", "b"=>"B" }
  #
  # CREDIT: Trans

  def traverse!(&block)
    replace(traverse(&block))
  end

end

