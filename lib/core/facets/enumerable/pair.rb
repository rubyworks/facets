module Enumerable

  # Like `each_slice(2)` but ensures the last 
  # element has a pair if odd sized.
  #
  #   [:a,1,:b,2,:c,3].pair.to_a  #=> [[:a,1],[:b,2],[:c,3]]
  #
  def pair(missing=nil)
    return to_enum(:pair) unless block_given?

    each_slice(2) do |kv|
      if kv.size == 1
        yield kv.first, missing
      else
        yield kv.first, kv.last
      end
    end
  end

end
