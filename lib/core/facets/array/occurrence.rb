class Array

  # Create a hash of each uniq element of the array
  # and how many time each appears.
  #
  # Examples
  #
  #   [:a,:a,:b,:c,:c,:c].occurrence
  #   #=> { :a => 2, :b => 1, :c => 3 }
  #
  #   [2,2,3,4,4,4].occurrence{|i| i % 2}
  #   #=> { 0 => 5, 1 => 1 }
  #
  def occurrence(&block)
    warn "Array#occurrence is deprecated. Use Array#tally instead.", uplevel: 1
    tally(&block)
  end

end

