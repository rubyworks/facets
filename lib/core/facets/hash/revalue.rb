class Hash

  # Generates a new hash where the values are the result of the passed in
  # block.  The block takes both the key and value of the current entry as
  # arguments.
  #
  #     hash = { a: 1, b: 2 }
  #     hash.revalue { |v| v + 1 }  # => { a: 2, b: 3 }
  #
  # Returns [Hash].
  #
  # Credit: Sean Mackesey

  def revalue(val_map=nil, &block)
    raise ArgumentError, "argument or block, not both" if val_map && block

    if !(val_map or block)
      raise ArgumentError, "must provide Hash arguments or a block"
      #block = lambda{|v| v.to_s}
    end

    if block
      hash = dup.clear  # to keep default_proc
      if block.arity.abs == 1
        each_pair do |k, v|
          hash[k] = block[v]     #hash[k] = block[v] || v
        end
      else
        each_pair do |k, v|
          hash[k] = block[k,v]   #hash[k] = block[k,v] || v
        end
      end
    else
      hash = dup.clear  # to keep default_proc
      each do |k,v|
        if val_map.key?(v)
          hash[k] = val_map[v]
        else
          hash[k] = v
        end
      end
    end

    hash
  end

  # The in-place version of Hash#revalue.
  #
  #     hash = { a: 1, b: 2 }
  #     hash.revalue! { |v| v + 1 }
  #     hash  # => { a: 2, b: 3 }
  #
  # Returns [Hash].
  #
  # Credit: Sean Mackesey

  def revalue!(val_map=nil, &block)
    replace(revalue(val_map, &block))
  end

end
