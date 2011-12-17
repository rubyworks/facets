class Array

  # Iterate over index and value. The intention of this
  # method is to provide polymorphism with Hash.
  #
  def each_pair #:yield:
    i = -1
    each_value do |x|
      yield(i+=1, x)
    end
  end

end

