class Array

  # Iterate over every nth element of an array.
  #
  # An optional offset can be given to start from a
  # specific index (default is 0).
  #
  #   [:a, :b, :c, :d, :e, :f].step(2).to_a    #=> [:a, :c, :e]
  #   [:a, :b, :c, :d, :e, :f].step(2, 1).to_a  #=> [:b, :d, :f]
  #   [:a, :b, :c, :d, :e, :f].step(3).to_a    #=> [:a, :d]
  #
  #   r = []
  #   [:a, :b, :c, :d].step(2) { |x| r << x }
  #   r   #=> [:a, :c]
  #
  # CREDIT: Ryan Duryea

  def step(n, offset=0) #:yield:
    if block_given?
      (offset...size).step(n).each do |i|
        yield(fetch(i))
      end
    else
      Enumerator.new do |y|
        (offset...size).step(n).each { |i| y << fetch(i) }
      end
    end
  end
end
