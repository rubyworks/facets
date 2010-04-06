class Hash

  # Returns a new hash created by traversing the hash and its subhashes,
  # executing the given block on the key and value. The block should
  # return a 2-element array of the form +[key, value]+.
  #
  #   h = { "A"=>"A", "B"=>"B", { "X"=>"X" } }
  #
  #   h.recursive_each{ |k,v| p [k.downcase, v] }
  #
  # produces
  #
  #   ["a", "A"]
  #   ["b", "B"]
  #   ["x", "X"]
  #
  # CREDIT: Trans

  def recursive_each(&block)
    if block
      each do |k,v|
        if Hash === v
          v = v.recursive(&block)
        elsif v.respond_to?(:to_hash)
          v = v.to_hash.recursive(&block)
        end
        block.call(k,v)
      end
    else
      to_enum(:recursive)
    end
  end

end

