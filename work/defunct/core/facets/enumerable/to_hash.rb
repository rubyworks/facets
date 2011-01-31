module Enumerable

  # Produces a hash from an Enumerable with index for keys.
  #
  #   enu = 'a'..'b'
  #   enu.to_hash  #=> { 0=>'a', 1=>'b' }
  #
  # If a block is passed, the hash values will be set by
  # calling the block with the enumerated element and it's
  # counter.
  #
  #   enu = 'a'..'b'
  #   enu.to_hash{ |e,i| e }  #=> { 0=>'a', 1=>'b' }
  #
  # See also #mash.
  #
  # CREDIT: Trans

  def to_hash( &blk )
    h = {}
    if blk
      each_with_index{ |e,i| h[i] = blk.call(e,i) }
    else
      each_with_index{ |e,i| h[i] = e }
    end
    h
  end

end

