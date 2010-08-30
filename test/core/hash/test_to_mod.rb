covers 'facets/hash/to_mod'

testcase Hash do

  unit :to_mod do
    h = { :a=>1, :b=>2 }
    m = h.to_mod
    Module.assert === m
  end

  unit :to_mod => "check methods" do
    h = { :a=>1, :b=>2 }
    m = h.to_mod
    x = Class.new{ include m }.new
    x.a.assert == 1
    x.b.assert == 2
  end

end

