Covers 'facets/hash/recursive'

Case Hash do

  Unit :recursive => "each" do
    h = {:a=>1,:b=>{:c=>3}}
    a = []
    h.recursive.each{ |k,v| a << [k,v] }
    a.assert.include? [:a,1]
    a.assert.include? [:b,{:c=>3}]
    a.assert.include? [:c,3]
  end

  Unit :recursive => "map" do
    h = {:a=>1,:b=>{:c=>3}}
    a = h.recursive.map{ |k,v| Hash===v ? [k, v.succ] : [k,v] }
    a.assert.include? [:a,1]
    a.assert.include? [:b,[[:c,3]]]
  end

  Unit :recursive => "map (moot)" do
    h = {:a=>1,:b=>{:c=>3}}
    a = h.recursive.map{ |k,v| [k, v] }
    a.assert.include? [:a,1]
    a.assert.include? [:b,[[:c,3]]]
  end

end

