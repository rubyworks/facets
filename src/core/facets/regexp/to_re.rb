class Regexp

  # Like #to_re, but following Ruby's formal definitions,
  # only a Regular expression type object will respond to this.
  #
  # Note that to be of much real use this should be defined in core Ruby.
  #
  # CREDIT: Florian Gross

  def to_regexp
    self
  end

  # Simply returns itself. Helpful when converting
  # strings to regular expressions, where regexp
  # might occur as well --in the same vien as using
  # #to_s on symbols. The parameter is actaully a
  # dummy parameter to coincide with String#to_re.
  #
  #   /abc/.to_re  #=> /abc/
  #
  # CREDIT: Trans

  def to_re(esc=false)
    self  # Of course, things really should know how to say "I" ;)
  end

end
