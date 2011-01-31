covers 'facets/enumerable/map_by'

tests Enumerable do

  unit :map_by do
    a = [1,2,3,4,5]
    r = a.map_by{ |e| [e % 2, e + 1] }
    r.assert == { 0=>[3,5], 1=>[2,4,6] }
  end

  unit :map_by => "works well with a hash" do
    h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2}
    r = h.map_by{ |k,v| [v, k.downcase] }
    r.assert == {1=>["a", "b", "c"], 2=>["d", "e"]}
  end

  unit :map_by => "if only a scalar is returned, #map_by acts like #group_by" do
    h = {"A"=>1, "B"=>1, "C"=>1, "D"=>2, "E"=>2}
    r = h.map_by{ |k,v| v }
    r.assert == {1=>[["A",1], ["B",1], ["C",1]], 2=>[["D",2], ["E",2]]}
  end

end
