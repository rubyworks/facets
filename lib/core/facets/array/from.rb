class Array

  # Returns the tail of the array from +position+.
  #
  #   %w( a b c d ).from(0)  # => %w( a b c d )
  #   %w( a b c d ).from(2)  # => %w( c d )
  #   %w( a b c d ).from(10) # => nil
  #   %w().from(0)           # => %w()
  #
  def from(position)
    self[position..-1]
  end

  # Returns the beginning of the array up to +position+.
  #
  #   %w( a b c d ).upto(0)  # => %w( a )
  #   %w( a b c d ).upto(2)  # => %w( a b c )
  #   %w( a b c d ).upto(10) # => %w( a b c d )
  #   %w().upto(0)           # => %w()
  #
  def upto(position)
    self[0..position]
  end

end

