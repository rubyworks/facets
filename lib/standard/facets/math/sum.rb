module Math

  # Returns sum.  When a block is given, summation is taken over the 
  # each result of block evaluation.
  #
  def self.sum(array) #:yield:
    sum = 0.0
    if block_given?
      array.each{|i| sum += yield(i)}
    else
      array.each{|i| sum += i}
    end
    sum
  end

end
