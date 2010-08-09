Covers 'facets/enumerable/group_by'

Case Enumerable do

  Unit :group_by => "for array" do
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    e = {0=>[0, 2, 4, 6, 8], 1=>[1, 3, 5, 7, 9]}
    r = a.group_by{ |x| x % 2 }  #.each{|k, v| v.sort!})
    r.assert == e
  end

  Unit :group_by => "for hash" do
    h = {0=>0, 1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
    e = {0=>[[0, 0], [2, 2], [4, 4], [6, 6], [8, 8]], 1=>[[1, 1], [3, 3], [5, 5], [7, 7], [9, 9]]}
    r = h.group_by{|k, v| v%2}.each{|k, v| v.sort!}
    r.assert == e
  end

  Unit :group_by => "for range" do
    r = (1..5).group_by{ |n| n % 3 }
    e = { 0 => [3], 1 => [1, 4], 2 => [2,5] }
    r.assert == e
  end

  Unit :group_by => "for array of string" do
    r = ["I had", 1, "dollar and", 50, "cents"].group_by{ |e| e.class }
    e = { String => ["I had","dollar and","cents"], Fixnum => [1,50] }
    r.assert == e
  end

end

