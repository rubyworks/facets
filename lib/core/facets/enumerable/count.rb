require 'facets/hash/count'

module Enumerable

  unless method_defined?(:count)

    # Count the number of items in an enumerable
    # equal (==) to the given object(s).
    #
    #   e = [ 'a', '1', 'a' ]
    #   e.count('1')     #=> 1
    #   e.count('a')     #=> 2
    #   e.count('a', 1)  #=> 3
    #
    # Note that Hash#count only considers values.
    #
    #   e = { 'a' => 2, 'x' => 2, 'b' => 1 }
    #   e.count(1) #=> 1
    #   e.count(2) #=> 2
    #
    # CREDIT: Trans

    def count(*items, &block)
      if block || !items.empty?
        r = self
        r = r.select(&block) if block
        r = r.select{ |x| items.any?{ |i| i == x } } if !items.empty?
        r.size
      else
        begin
          size
        rescue
          i=0; each{ |e| i+=1 }; i
        end
      end
    end

  end

end

