class Array

  # Iterate over every nth element of an array.
  #
  #   r = []
  #   [:a, :b, :c, :d].step(2) { |x| r << x }
  #   r   #=> [:b, :d]
  #   
  # Without a block it returns an Enumerator.
  #
  #   [:a, :b, :c, :d].step(1).to_a   #=> [:a, :b, :c, :d]
  #   [:a, :b, :c, :d].step(2).to_a   #=> [:b, :d]
  #   [:a, :b, :c, :d].step(3).to_a   #=> [:c]
  #   [:a, :b, :c, :d].step(5).to_a   #=> []
  #
  # CREDIT: Ryan Duryea

  def step(n) #:yield:
    if block_given?
      ((n - 1)...size).step(n).each do |i|
        yield(fetch(i))
      end
    else
      Enumerator.new(size / n) do |y|
        ((n - 1)...self.size).step(n).each { |i| y << fetch(i) }  
      end
    end
  end
end


