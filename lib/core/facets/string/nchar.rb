class String

  # Returns _n_ characters of the string. If _n_ is positive
  # the characters are from the beginning of the string.
  # If _n_ is negative from the end of the string.
  #
  # Alternatively a replacement string can be given, which will
  # replace the _n_ characters.
  #
  #    str = "this is text"
  #    str.nchar(4)            #=> "this"
  #    str.nchar(4, 'that')    #=> "that"
  #    str                     #=> "that is text"
  #
  #   CREDIT: ?

  def nchar(n, replacement=nil)
    if replacement
      s = self.dup
      n > 0 ? (s[0...n] = replacement) : (s[n..-1] = replacement)
      return s
    else
      n > 0 ? self[0...n] : self[n..-1]
    end
  end

end

