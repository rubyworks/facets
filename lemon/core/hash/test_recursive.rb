Covers 'facets/hash/recursive'

Case Hash do

  Unit :recursive => "each" do
    a = []
    {:a=>1,:b=>{:c=>3}}.recursive.each{ |k,v| a << [k,v] }
    a.assert == [[:a,1],[:c,3], [:b,{:c=>3}]]
  end

  Unit :recursive => "map" do
    a = {:a=>1,:b=>{:c=>3}}.recursive.map{ |k,v| Hash===v ? [k, v.succ] : [k,v] }
    a.assert == [[:a,1],[:b,[[:c,3]]]]
  end

  Unit :recursive => "map (moot)" do
    a = {:a=>1,:b=>{:c=>3}}.recursive.map{ |k,v| [k, v] }
    a.assert == [[:a,1],[:b,[[:c,3]]]]
  end

end

