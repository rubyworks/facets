class String

  # Turns a string into a regular expression.
  #
  #   "a?".to_re  #=> /a?/
  #
  #  CREDIT: Trans

  def to_re(esc=false)
    Regexp.new((esc ? Regexp.escape(self) : self))
  end

  # Turns a string into a regular expression.
  # By default it will escape all characters.
  # Use <tt>false</tt> argument to turn off escaping.
  #
  #   "[".to_rx  #=> /\[/
  #
  #  CREDIT: Trans

  def to_rx(esc=true)
    Regexp.new((esc ? Regexp.escape(self) : self))
  end

end

