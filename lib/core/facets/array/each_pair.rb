class Array

  # Iterate over index and value. The intention of this
  # method is to provide polymorphism with Hash.
  #
  def each_pair #:yield:
    each_with_index {|e, i| yield(i,e) }
  end

end

