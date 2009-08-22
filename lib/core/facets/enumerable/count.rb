module Enumerable

  unless method_defined?(:count)

    # Count the number of items in an enumerable
    # equal (==) to the given object.
    #
    #   e = [ 'a', '1', 'a' ]
    #   e.count('1')    #=> 1
    #   e.count('a')    #=> 2
    #
    # Count can also handle multiple-valued blocks.
    #
    #   e = { 'a' => 2, 'a' => 2, 'b' => 1 }
    #   e.count('a',2)  #=> 1
    #
    # CREDIT: Trans

    def count(item=ArgumentError, &blk)
      return select(&blk).size              if block_given?
      return select{ |*i| item == i }.size  if ArgumentError == item
      begin
        size
      rescue
        (i=0; each{|e| i+=1 }; i)
      end
    end

  end

end

