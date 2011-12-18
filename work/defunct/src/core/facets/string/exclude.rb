class String

  # The inverse of include?.
  #
  def exclude?(str)
    !include?(str)
  end

end

