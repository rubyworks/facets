class String

  # Removes all occurrences of a pattern in a string.
  #
  # Returns a new [String] with all occurrences of the pattern removed.
  def remove(pattern)
    gsub(pattern, '')
  end

  # Removes all occurrences of a pattern in a string.
  #
  # Returns the [String] with all occurrences of the pattern removed.
  def remove!(pattern)
    gsub!(pattern, '')
  end

  # Removes occurances of a string or regexp. This is an operator
  # form for the #remove method.
  #
  #   ("HELLO HELLO" - "LL")    #=> "HEO HEO"
  #   ("HELLO PERL" - /L\S/)    #=> "HEO PERL"
  #
  # Returns a new [String] with all pattern matches removed.
  #
  # CREDIT: Benjamin David Oakes
  def -(pattern)
    gsub(pattern, '')
  end

end
