class Array

  # Alias for shift which removes an object off first slot of an array.
  # This is the opposite of pop.
  alias_method :pull, :shift

  # Peek at the top of the stack (the end of the array).
  #
  #   a = [1, 2, 3]
  #   a.peek          #=> 3
  #   a               #=> [1, 2, 3]
  #
  # Or provide an index to inspect the array from back to front.
  def peek(i=0)
    i = -(i + 1)
    fetch(i)
  end

  # Put an object on the bottom of the stack (front of the array).
  #
  #   a = [2, 3]
  #   a.poke(1)
  #   a               #=> [1, 2, 3]
  #
  # Or supply an index and #poke works like #insert.
  def poke(x, i=0)
    insert(i,x)
  end

end
