class Regexp

  # Is a regular expression multiline?
  #
  #   /x/.multiline?   #=> false
  #   /x/m.multiline?  #=> true
  #
  def multiline?
    options & MULTILINE == MULTILINE
  end

end

