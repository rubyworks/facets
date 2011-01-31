covers 'facets/hash/recursively'
covers 'facets/hash/graph'

tests Hash do

  unit :recursively => "each" do
    h = {:a=>1,:b=>{:c=>3}}
    r = []
    h.recursively.each{ |k,v| r << [k,v] }
    r.assert.include? [:a,1]
    r.assert.include? [:b,{:c=>3}]
    r.assert.include? [:c,3]
  end

  unit :recursively => "map" do
    h = {:a=>1,:b=>{:c=>3}}
    r = h.recursively{ |k,v| [k,v] }.map{ |k,v| [k, v.succ] }
    r.assert.include? [:a,2]
    r.assert.include? [:b,[[:c,4]]]
  end

  unit :recursively => "map (moot)" do
    h = {:a=>1,:b=>{:c=>3}}
    a = h.recursively.map{ |k,v| [k, v] }
    a.assert.include? [:a,1]
    a.assert.include? [:b,[[:c,3]]]
  end

  unit :recursively => 'graph' do
    h = {:a=>1,:b=>{:c=>3}}
    r = h.recursively{ |k,v| [k.to_s, v] }.graph{ |k,v| [k.to_s, v.to_s] }
    r.assert == {'a'=>'1','b'=>{'c'=>'3'}}
  end

  unit :recursively => 'graph!' do
    h = {:a=>1,:b=>{:c=>3}}
    h.recursively{ |k,v| [k.to_s, v] }.graph!{ |k,v| [k.to_s, v.to_s] }
    h.assert == {'a'=>'1','b'=>{'c'=>'3'}}
  end

  unit :recursively => 'mash' do
    h = {:a=>1,:b=>{:c=>3}}
    r = h.recursively{ |k,v| [k.to_s, v] }.mash{ |k,v| [k.to_s, v.to_s] }
    r.assert == {'a'=>'1','b'=>{'c'=>'3'}}
  end

  unit :recursively => 'mash!' do
    h = {:a=>1,:b=>{:c=>3}}
    h.recursively{ |k,v| [k.to_s, v] }.mash!{ |k,v| [k.to_s, v.to_s] }
    h.assert == {'a'=>'1','b'=>{'c'=>'3'}}
  end

  #unit :recursively => 'merge' do
  #  h1 = {:a=>1,:b=>{:c=>3}}
  #  h2 = {:b=>{:d=>4}}
  #  r = h1.recursively.merge(h2)
  #  r.assert == {:a=>1,:b=>{:c=>3, :d=>4}}
  #end

  #unit :recursively => 'merge!' do
  #  h1 = {:a=>1,:b=>{:c=>3}}
  #  h2 = {:b=>{:d=>4}}
  # h1.recursively.merge!(h2)
  #  h1.assert == {:a=>1,:b=>{:c=>3, :d=>4}}
  #end

end
