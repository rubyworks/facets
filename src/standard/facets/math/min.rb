module Math

  #
  def self.min(array, &block)
    if block_given?
      if min = array.find{ |i| i }
        min = yield(min)
        array.each do |i|
          j = yield(i)
          min = j if min > j
        end
        min
      end
    else
      array.min
    end
  end

  #
  def self.max(array, block)
    if block_given?
      if max = find{|i| i}
        max = yield(max)
        each{|i|
          j = yield(i)
          max = j if max < j
        }
        max
      end
    else
      array.max
    end
  end

end
