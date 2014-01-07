class Array

  # Returns a list of elements that occur +n+ times.
  #
  # If +n+ is a Range then returns elements that occur a number
  # of time within the range.
  #
  # Examples
  #
  #  [0,1,1,1,3,0,1,2,4].occur(3) #=> [1]
  #
  #  [0,1,1,1,3,0,1,2,4].occur(2..4) #=> [0,1]
  #
  # Returns [Array] of reoccurring elements.
  #
  # CREDIT: Robert Dober

  def occur(n=nil) #:yield:
    h = Hash.new(0)

    each do |i|
      h[i] += 1
    end

    case n
    when nil
      h.delete_if{ |_,v| ! yield(v) }.keys
    when Range
      h.delete_if{ |_,v| ! n.include?(v) }.keys
    else
      h.delete_if{|_,v| v != n}.keys
    end
  end

  # Plural alias of #occur.
  alias :occurs :occur

end
