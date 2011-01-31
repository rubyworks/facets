class Array

  # Simplify an array by flattening it then compacting it.
  #
  #   [1,[2,nil,[3]],nil,4].collapse  #=> [1,2,3,4]
  #
  def collapse
    flatten.compact
  end

end

