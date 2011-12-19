class String

  # Transform a string into an acronym.
  #
  # CREDIT: Robert Fey
  #
  def acronym
	  gsub(/(([a-zA-Z0-9])([a-zA-Z0-9])*)./,"\\2")
  end

end
