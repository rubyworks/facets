covers 'facets/hash/recurse'

testcase Hash do

  unit :recurse do
    h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
    g = h.recurse{|h| h.inject({}){|h,(k,v)| h[k.to_s] = v; h} }
    g.assert == {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  end

  unit :recurse! do
    h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
    h.recurse!{|h| h.inject({}){|h,(k,v)| h[k.to_s] = v; h} }
    h.assert == {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  end

end

