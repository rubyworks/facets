class String

  # CREDIT: Robert Fey
  def acronymize
	  gsub(/(([a-zA-Z0-9])([a-zA-Z0-9])*)./,"\\2")
  end

end
