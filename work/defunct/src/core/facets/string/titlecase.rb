class String

  # Title case.
  #
  #   "this is a string".titlecase
  #   #=> "This Is A String"
  #
  # CREDIT: Eliazar Parra

  def titlecase
    gsub(/\b\w/){ $`[-1,1] == "'" ? $& : $&.upcase }
  end

end

