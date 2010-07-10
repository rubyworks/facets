class String

  # Returns an array of characters.
  #
  #   "abc".characters.to_a  #=> ["a","b","c"]
  #
  # TODO: Probably should make this an enumerator. With #scan?
  def characters
    split(//)
  end

end

