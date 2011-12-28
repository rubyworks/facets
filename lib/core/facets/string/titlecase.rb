class String

  # Transform a string into a form that makes for an acceptable title.
  #
  #   "this is a string".titlecase
  #   #=> "This Is A String"
  #
  # @author Eliazar Parra
  # @author Angelo Lakra (apostrophe fix)

  def titlecase
    tr('_', ' ').
    gsub(/\s+/, ' ').
    gsub(/\b\w/){ $`[-1,1] == "'" ? $& : $&.upcase }
  end

  # Transform a string into a sentence like form.
  #
  #   "This Is A String".briefcase
  #   #=> "This is a string"
  #
  def briefcase
    titlecase.capitalize
  end

end

