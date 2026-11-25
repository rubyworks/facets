class String

  # Returns an array of the paragraphs in a string. Paragraphs are
  # separated by one or more blank lines, and a line holding only
  # whitespace counts as blank.
  #
  #   "One.\nStill one.\n\nTwo.".paragraphs  #=> ["One.\nStill one.", "Two."]
  #
  # The lines of a paragraph are left as they are. Blank lines at the
  # start and end of the string are ignored, as is whitespace at the end
  # of each paragraph.
  #
  # CREDIT: Trans
  #
  def paragraphs
    strip.split(/(?:\r?\n[ \t]*){2,}/).map{ |para| para.rstrip }.reject{ |para| para.empty? }
  end

end
