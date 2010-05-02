require 'facets/enumerable/cluster_by'

Case Enumerable do

  Unit :cluster_by => "on an array" do
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    e = [[0, 2, 4, 6, 8], [1, 3, 5, 7, 9]]
    r = a.cluster_by{|x| x % 2} #.each{|a| a.sort!}
    r.assert == e
  end

  Unit :cluster_by => "on a hash" do
    h = {0=>0, 1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
    e = [[[0, 0], [2, 2], [4, 4], [6, 6], [8, 8]], [[1, 1], [3, 3], [5, 5], [7, 7], [9, 9]]]
    r = h.cluster_by{|k, v| v % 2}.each{|a| a.sort!}
    r.assert == e
  end

  Unit :cluster_by => "on an empty array" do
    r = [].cluster_by{ |a| a }
    r.assert == []
  end

end


