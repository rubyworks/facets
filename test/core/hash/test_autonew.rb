Covers 'facets/hash/autonew'

Case Hash do

  MetaUnit :autonew do
    h = Hash.autonew
    h['s1']['p1'] = 4
    h['s1']['p2'] = 5
    h['s1']['p3'] = 2
    h['s1']['p4'] = 3
  
    h.assert == {"s1"=>{"p1"=>4, "p4"=>3, "p3"=>2, "p2"=>5}}
  
    h['s1'].keys.sort.assert == ["p1", "p2", "p3", "p4"]
  end

end

