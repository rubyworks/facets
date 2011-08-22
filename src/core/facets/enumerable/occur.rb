module Enumerable

  # Returns an array of elements for the elements that occur n times.
  # Or according to the results of a given block.
  #
  #   a = [1,1,2,3,3,4,5,5]
  #
  #   a.occur(1).sort               #=> [2,4]
  #   a.occur(2).sort               #=> [1,3,5]
  #   a.occur(3).sort               #=> []
  #
  #   a.occur(1..1).sort            #=> [2,4]
  #   a.occur(2..3).sort            #=> [1,3,5]
  #
  #   a.occur { |n| n == 1 }.sort   #=> [2,4]
  #   a.occur { |n| n > 1 }.sort    #=> [1,3,5]
  #
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

