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

  unit :recurse => "with Arrays" do
    require 'facets/array/recurse'
    objects = []
    struct = {:a => 3, :b => [4, 5, {:c=>6}]} 
    struct.recurse(Array, Hash){|o| objects << o; o }

    objects.assert.include?( {:c=>6}                          )
    objects.assert.include?( [4, 5, {:c=>6}]                  )
    objects.assert.include?( struct                           )

    objects.length.assert == 3
  end

end

