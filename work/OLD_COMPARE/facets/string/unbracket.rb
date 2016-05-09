require 'facets/string/bracket'

class String

  #def self.bra2ket
  #  @bra2ket ||= { '['=>']', '('=>')', '{'=>'}', '<'=>'>' }
  #end

  # Return a new string embraced by given brakets.
  # If only one bracket char is given it will be placed
  # on either side.
  #
  #   "{unwrap me}".debracket('{')        #=> "unwrap me"
  #   "--unwrap me!".debracket('--','!')  #=> "unwrap me!"
  #
  def unbracket(bra=nil, ket=nil)
    if bra
      ket = Sring.bra2ket[bra] unless ket
      ket = ket ? ket : bra
      s = self.dup
      s.gsub!(%r[^#{Regexp.escape(bra)}], '')
      s.gsub!(%r[#{Regexp.escape(ket)}$], '')
      return s
    else
      if m = String.bra2ket[ self[0,1] ]
        return self.slice(1...-1) if self[-1,1]  == m
      end
    end
    return self.dup  # if nothing else
  end

  # Inplace version of #debraket.
  def unbracket!(bra=nil, ket=nil)
    self.replace( unbracket(bra, ket) )
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
