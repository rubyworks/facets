class String
  # @param [Integer] length Length for string to clear.
  #
  # @return [String] String that clears given length.
  def clear_length(length)
    return self if self.length < length

    self[0..(length - 1)]
  end
end
