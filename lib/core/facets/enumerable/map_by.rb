module Enumerable

  # Like #group_by, but maps the second value returned from the block.
  #
  #   a = [1,2,3,4,5]
  #   a.map_by{ |e| [e % 2, e + 1] }
  #   #=> { 0=>[3,5], 1=>[2,4,6] }
  #
  # Works well with a hash too.
  #
  #   h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2}
  #   h.map_by{ |k,v| [v, k.downcase] }
  #   #=> {1=>["a", "b", "c"], 2=>["d", "e"]}
  #
  # If a second value is not returned, #map_by acts like #group_by.
  #
  #   h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2}
  #   h.map_by{ |k,v| v }
  #   #=> {1=>[["A",1], ["B",1], ["C",1]], 2=>[["D",2], ["E",2]]}
  #
  def map_by #:yield:
    res = {}
    each do |a|
      k,v = yield(*a)
      if v
        (res[k] ||= []) << v
      else
        (res[k] ||= []) << a
      end
    end
    res
  end

end

