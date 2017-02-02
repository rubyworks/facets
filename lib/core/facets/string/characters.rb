class String

  # Returns an array of characters.
  #
  #   "abc".characters.to_a  #=> ["a","b","c"]
  #
  alias :characters, :each_char

end

