module Enumerable

  # Returns an array of elements for the elements that occur n times.
  # Or according to the results of a given block.
  #
  #   [1,1,2,3,3,4,5,5].occur(1)             #=> [2,4]
  #   [1,1,2,3,3,4,5,5].occur(2)             #=> [1,3,5]
  #   [1,1,2,3,3,4,5,5].occur(3)             #=> []
  #
  #   [1,2,2,3,3,3].occur(1..1)              #=> [1]
  #   [1,2,2,3,3,3].occur(2..3)              #=> [2,3]
  #
  #   [1,1,2,3,3,4,5,5].occur { |n| n == 1 } #=> [2,4]
  #   [1,1,2,3,3,4,5,5].occur { |n| n > 1 }  #=> [1,3,5]
  #
  #   CREDIT: ?

  def occur(n=nil) #:yield:
    result = Hash.new { |hash, key| hash[key] = Array.new }
    self.each do |item|
      key = item
      result[key] << item
    end
    if block_given?
      result.reject! { |key, values| ! yield(values.size) }
    else
      raise ArgumentError unless n
      if Range === n
        result.reject! { |key, values| ! n.include?(values.size) }
      else
        result.reject! { |key, values| values.size != n }
      end
    end
    return result.values.flatten.uniq
  end

end

