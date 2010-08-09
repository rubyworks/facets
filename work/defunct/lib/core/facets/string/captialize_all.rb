class String

  # Capitalize all words (or other patterned divisions) of a string.
  #
  #   "this is a test".capitalize_all  #=> "This Is A Test"
  #
  # TODO: May deprecate b/c YAGNI.
  #
  # CREDIT Richard Laugesen

  def capitalize_all(pattern=$;, *limit)
    split(pattern, *limit).select{ |w| w.capitalize! || w }.join(" ")
  end

end

