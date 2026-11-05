class String

  # Returns the string, first removing all whitespace on both ends of
  # the string, and then changing remaining consecutive whitespace
  # groups into one space each. Unicode whitespace, such as a
  # non-breaking space, counts too, as it does in ActiveSupport.
  #
  #   %{ Multi-line
  #      string }.squish                   # => "Multi-line string"
  #
  #   " foo   bar    \n   \t   boo".squish # => "foo bar boo"
  #
  def squish
    dup.squish!
  end

  # Performs a destructive squish. See String#squish.
  def squish!
    gsub!(/[[:space:]]+/, ' ')
    strip!
    self
  end

end
