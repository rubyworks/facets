class Array

  # Not empty?
  #
  #   [].not_empty?     #=> false
  #   [1,2].not_empty?  #=> true

  def not_empty?
    !empty?
  end

end

