class Array

  # NOTE: Deprecated #each_uniq_pair, just use #each_combination instead.
  
  # Processes each unique pair (of indices, not value)
  # in the array by yielding them to the supplied block.
  #
  #   a = [1,2,3,4]
  #   a.each_unique_pair{ |a,b| puts a+','+b }
  #
  # produces
  #
  #   1,2
  #   1,3
  #   1,4
  #   2,3
  #   2,4
  #   3,4
  #
  # This does not guarantee the uniqueness of values.
  # For example:
  #
  #   a = [1,2,1]
  #   a.each_unique_pair{ |a,b| puts a+','+b }
  #
  # prduces
  #
  #   1,2
  #   1,1
  #   2,1
  #
  # This is equivalent to <tt>each_combination(2){ ... }</tt>.

  def each_unique_pair(&yld)
    self.each_combination(2,&yld)
    #s = self.to_a
    #self.each_with_index{ |a,i|
    #  self[(i+1)..-1].each{ |b| yield a,b }
    #}
  end

end

