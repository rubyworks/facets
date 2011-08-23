class String

  # Binary XOR of two strings. 
  #
  #   a = "\000\000\001\001" ^ "\000\001\000\001"
  #   b = "\003\003\003" ^ "\000\001\002"
  #
  #   a  #=> "\000\001\001\000"
  #   b  #=> "\003\002\001"
  #
  def ^(aString)
    a = self.unpack('C'*(self.length))
    b = aString.unpack('C'*(aString.length))
    if (b.length < a.length)
      (a.length - b.length).times { b << 0 }
    end
    xor = ""
    0.upto(a.length-1) { |pos|
      x = a[pos] ^ b[pos]
      xor << x.chr()
    }
    return(xor)
  end

end

