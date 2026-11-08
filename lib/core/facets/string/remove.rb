class String

  # Removes all occurrences of one or more patterns in a string.
  #
  #   "foo bar".remove("o")       #=> "f bar"
  #   "foo bar".remove(/o/, "b")  #=> "f ar"
  #
  # Returns a new [String] with all occurrences of the patterns removed.
  def remove(*patterns)
    dup.remove!(*patterns)
  end

  # Removes all occurrences of one or more patterns in a string.
  #
  # Returns the [String] with all occurrences of the patterns removed,
  # even if nothing was removed.
  def remove!(*patterns)
    patterns.each { |pattern| gsub!(pattern, '') }
    self
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
