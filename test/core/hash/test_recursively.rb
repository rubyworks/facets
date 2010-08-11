covers 'facets/hash/recursively'

testcase Hash do

  unit :recursively do
    h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
    g = h.recursively{|h| h.inject({}){|h,(k,v)| h[k.to_s] = v; h} }
    g.assert == {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  end

  unit :recursively! do
    h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
    h.recursively!{|h| h.inject({}){|h,(k,v)| h[k.to_s] = v; h} }
    h.assert == {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  end

end

