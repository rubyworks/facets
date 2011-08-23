class String

  BRA2KET = { '['=>']', '('=>')', '{'=>'}', '<'=>'>' }

  # Return a new string embraced by given brackets.
  # If only one bracket char is given it will be placed
  # on either side.
  #
  #   "wrap me".bracket('{')        #=> "{wrap me}"
  #   "wrap me".bracket('--','!')   #=> "--wrap me!"
  #
  # CREDIT: Trans

  def bracket(bra, ket=nil)
    #ket = String.bra2ket[$&] if ! ket && /^[\[({<]$/ =~ bra
    ket = BRA2KET[bra] unless ket
    "#{bra}#{self}#{ket ? ket : bra}"
  end

  # Inplace version of #bracket.
  #
  # CREDIT: Trans

  def bracket!(bra, ket=nil)
    self.replace(bracket(bra, ket))
  end

  # Return a new string with the given brackets removed.
  # If only one bracket char is given it will be removed
  # from either side.
  #
  #   "{unwrap me}".unbracket('{')        #=> "unwrap me"
  #   "--unwrap me!".unbracket('--','!')  #=> "unwrap me"
  #
  # CREDIT: Trans

  def unbracket(bra=nil, ket=nil)
    if bra
      ket = BRA2KET[bra] unless ket
      ket = ket ? ket : bra
      s = self.dup
      s.gsub!(%r[^#{Regexp.escape(bra)}], '')
      s.gsub!(%r[#{Regexp.escape(ket)}$], '')
      return s
    else
      if m = BRA2KET[ self[0,1] ]
        return self.slice(1...-1) if self[-1,1]  == m
      end
    end
    return self.dup  # if nothing else
  end

  # Inplace version of #unbracket.
  #
  # CREDIT: Trans

  def unbracket!(bra=nil, ket=nil)
    self.replace( unbracket(bra, ket) )
  end

  # TODO: rename #bracket to #embrace ?

end

