class Hash

  # Returns a new hash created by traversing the hash and its subhashes,
  # executing the given block on the key and value. The block should
  # return a 2-element array of the form +[key, value]+.
  #
  #   h = {"A"=>"A", "B"=>"B", {"X"=>"X"}}
  #
  #   g = h.recursive_graph{ |k,v| [k.downcase, v] }
  #
  #   g  #=> {"a"=>"A", "b"=>"B", {"x"=>"X"}}
  #
  # CREDIT: Trans

  def recursive_graph(&block)
    inject({}) do |h,(k,v)|
      if Hash === v
        v = v.recursive_graph(&block)
      elsif v.respond_to?(:to_hash)
        v = v.to_hash.recursive_graph(&block)
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
  #   h.traverse! { |k,v| [k.downcase, v] }
  #
  #   h  #=> { "a"=>"A", "b"=>"B" }
  #
  # CREDIT: Trans

  def recursive_graph!(&block)
    replace(recursive_graph(&block))
  end

end

