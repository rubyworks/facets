class MatchData

  # Return the primary match string. This is equivalent to +md[0]+.
  #
  #   md = /123/.match "123456"
  #   md.match  #=> "123"
  #
  #  CREDIT: Martin DeMello

  def match(index=0)
    self[index]
  end

end

