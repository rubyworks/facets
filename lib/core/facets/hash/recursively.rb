class Hash

  # Apply a block to hash, and recursively apply that block
  # to each subhash.
  #
  #   h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
  #   h.recursively{|h| h.rekey(&:to_s) }
  #   => {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  #
  def recursively(&block)
    h = inject({}) do |hash, (key, value)|
      if value.is_a?(Hash)
        hash[key] = value.recursively(&block)
      else
        hash[key] = value
      end
      hash
    end
    yield h
  end

  #

  def recursively!(&block)
    replace(recursively(&block))
  end

end

