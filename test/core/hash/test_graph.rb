Covers 'facets/hash/graph'

Case Hash do

  Unit :graph! => "using a hash" do
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.graph!{ |k,v| { k => v+1 } }
    a.assert == e
  end

  Unit :graph! => "using an associative array" do
    h  = {:a=>1,:b=>2,:c=>3}
    h.graph!{ |k,v| [v, v*v] }
    h.assert == {1=>1, 2=>4, 3=>9}
  end

  Unit :mash! => "using a hash" do
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.mash!{ |k,v| { k => v+1 } }
    a.assert == e
  end

  Unit :mash! => "using an associative array" do
    h  = {:a=>1,:b=>2,:c=>3}
    h.mash!{ |k,v| [v, v*v] }
    h.assert == {1=>1, 2=>4, 3=>9}
  end

end

