class Array

  # Determines the _sorted_ middle element.
  #
  #   a = %w{a a b b c c c}
  #   a.median     #=> "b"
  #
  # When there are an even number of elements, the greater
  # of the two middle elements is given.
  #
  #   a = %w{a a b b c c c d}
  #   a.median     #=> "c"
  #
  # An offset can be supplied to get an element relative
  # to the middle.
  #
  #   a = %w{a a b b c c c d}
  #   a.median(-1) #=> "b"
  #
  # The the array is empty, +nil+ is returned.
  #
  # @return [Object] sorted middle element
  def median(offset=0)
    return nil if self.size == 0

    tmp = self.sort
    mid = (tmp.size / 2).to_i + offset

    tmp[mid]
  end

end
