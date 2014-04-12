class Hash

  # Take a subset of the hash, based on keys given or a block
  # that evaluates to true for each hash key.
  #
  #   {'a'=>1, 'b'=>2}.subset('a')            #=> {'a'=>1}
  #   {'a'=>1, 'b'=>2}.subset{|k| k == 'a'}   #=> {'a'=>1}
  #
  # CREDIT: Alexey Petrushin
  def subset(*keys, &block)
    h = {}

    if block
      raise ArgumentError, "subset arguments and block are exclusive parameters" unless keys.empty?
      each do |k, v|
        h[k] = v if block.call(k)
      end
    else
      each do |k, v|
        h[k] = v if keys.include?(k)
      end
    end

    return h
  end

end
