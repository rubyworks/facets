class String

  # Returns an array of characters.
  #
  #   "abc 123".words  #=> ["abc","123"]
  #
  def words
    self.split(/\s+/)
  end

end

