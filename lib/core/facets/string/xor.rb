class String

  # XOR two string.
  #
  # TODO: This is used by crypt.rb, it needs to be documented.

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

