class Array

  # Returns last _n_ elements.
  #
  #   %w{W o r l d}.from(3)  #=> %w{l d}
  #
  def from(i)
    return self if i >= size
    self[i, size - i]
  end unless method_defined?(:from)

  # Fetch values from a start index thru an end index.
  #
  #   [1,2,3,4,5].thru(0,2)  #=> [1,2,3]
  #   [1,2,3,4,5].thru(2,4)  #=> [3,4,5]
  #
  #   [1,2,3,4,5].thru(2)  #=> [1,2,3]
  #   [1,2,3,4,5].thru(4)  #=> [1,2,3,4,5]
  #
  def thru(from, to=nil)
    from, to = 0, from unless to
    to = size - 1 if to >= size
    a = []
    i = from
    while i <= to
      a << self[i]
      i += 1
    end
    a
  end unless method_defined?(:thru)

end

