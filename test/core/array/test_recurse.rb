covers 'facets/array/recurse'

testcase Array do

  unit :recurse do
    a = ["a", ["b", "c", nil], nil]
    r = a.recurse{|a| a.compact! }
    r.assert ["a", ["b", "c"]]
  end

  unit :recurse! do
    a = ["a", ["b", "c", nil], nil]
    a.recurse!{|a| a.compact! }
    a.assert ["a", ["b", "c"]]
  end

  unit :recurse => "with Hashes" do
    require 'facets/hash/recurse'
    objects = []
    struct = [1, 2, {:a => 3, :b => [4, 5, {:c=>6}]}, [7, 8]]
    struct.recurse(Array, Hash){|o| objects << o; o } 

    objects.assert.include?( [7, 8]                           )
    objects.assert.include?( {:c=>6}                          )
    objects.assert.include?( [4, 5, {:c=>6}]                  )
    objects.assert.include?( {:a => 3, :b => [4, 5, {:c=>6}]} )
    objects.assert.include?( struct                           )

    objects.length.assert == 5
  end

end
