covers 'facets/to_hash'

testcase Array do

  unit :to_h do
    a = [ [:a,1], [:b,2] ]
    a.to_h.assert == { :a=>1, :b=>2 }
  end

  unit :to_h do
    a = [ [:a,1,2], [:b,2], [:c], [:d] ]
    a.to_h.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  end

  unit :to_h do
    a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
    a.to_h.assert == { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
  end

  unit :to_h_auto do
    a = [ [:a,1], [:b,2] ]
    a.to_h_auto.assert == { :a=>1, :b=>2 }
  end

  unit :to_h_auto do
    a = [ [:a,1,2], [:b,2], [:c], [:d] ]
    a.to_h_auto.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  end

  unit :to_h_auto do
    a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
    a.to_h_auto == { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
  end

  unit :to_h_splat do
    a = [:a,1,:b,2,:c]
    a.to_h_splat.assert == { :a=>1, :b=>2, :c=>nil }
  end

  unit :to_h_flat do
    a = [:a,1,[:b,2,:c]]
    a.to_h_flat.assert == { :a=>1, :b=>2, :c=>nil }
  end

  unit :to_h_assoc do
    a = [ [:a,1,2], [:b,2], [:c], [:d] ]
    a.to_h_assoc.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  end

  unit :to_h_assoc do
    a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
    a.to_h_assoc.assert == { :x=>[4] }
  end

  unit :to_h_multi => "#to_h can default to #to_h_multi" do
    a = [ [:a,1,2], [:b,2], [:c], [:d] ]
    a.to_h.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  end
  
  unit :to_h_multi do
    a = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
    a.to_h_multi.assert == { :a=>[1,2,3,4] }
  end

  #unit :to_hash do
  #end

end

testcase Hash do

  unit :to_h do
    {"a"=>1,"b"=>2}.to_h.assert == {"b"=>2,"a"=>1}
  end

  unit :to_hash do
    h = {:a=>1, :b=>2}
    h.to_hash.assert == h
  end

end

testcase Enumerable do

  unit :to_h do
    (1..4).to_h.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_auto do
    (1..4).to_h_auto.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_splat do
    (1..4).to_h_splat.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_flat do
    (1..4).to_h_flat.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_assoc do
    (1..4).to_h_assoc.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
  end

  unit :to_h_multi do
    (1..4).to_h_multi.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
  end

  ##unit :to_hash do
  ##  (1..4).to_hash.assert == { 1=>2, 3=>4 }
  ##end

end

testcase Enumerator do

  unit :to_h do
    (1..4).to_enum.to_h.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_auto do
    (1..4).to_enum.to_h_auto.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_splat do
    (1..4).to_enum.to_h_splat.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_flat do
    (1..4).to_enum.to_h_flat.assert == { 1=>2, 3=>4 }
  end

  unit :to_h_assoc do
    (1..4).to_enum.to_h_assoc.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
  end

  unit :to_h_multi do
    (1..4).to_enum.to_h_multi.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
  end

  ##unit :to_hash do
  ##  (1..4).to_hash.assert == { 1=>2, 3=>4 }
  ##end

end

testcase Struct do

  unit :to_h do
    s = Struct.new(:a,:b).new(1,2)
    s.to_h.assert == {:a=>1, :b=>2}
  end

end

testcase NilClass do

  unit :to_h do
    nil.to_h.assert == {}
  end

end

