covers 'facets/to_hash'

test_case Array do

  method :to_h do
    test do
      a = [ [:a,1], [:b,2] ]
      a.to_h.assert == { :a=>1, :b=>2 }
    end

    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.to_h.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end

    test do
      a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
      a.to_h.assert == { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
    end
  end

  method :to_h_auto do
    test do
      a = [ [:a,1], [:b,2] ]
      a.to_h_auto.assert == { :a=>1, :b=>2 }
    end

    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.to_h_auto.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end

    test do
      a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
      a.to_h_auto == { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
    end
  end

  method :to_h_splat do
    test do
      a = [:a,1,:b,2,:c]
      a.to_h_splat.assert == { :a=>1, :b=>2, :c=>nil }
    end
  end

  method :to_h_flat do
    test do
      a = [:a,1,[:b,2,:c]]
      a.to_h_flat.assert == { :a=>1, :b=>2, :c=>nil }
    end
  end

  method :to_h_assoc do
    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.to_h_assoc.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end
  end

  method :to_h_assoc do
    test do
      a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
      a.to_h_assoc.assert == { :x=>[4] }
    end
  end

  method :to_h_multi do
    test  "#to_h can default to #to_h_multi" do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.to_h.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end
  
    test do
      a = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
      a.to_h_multi.assert == { :a=>[1,2,3,4] }
    end
  end

  #method :to_hash do
  #end

end

test_case Hash do

  method :to_h do
    test do
      {"a"=>1,"b"=>2}.to_h.assert == {"b"=>2,"a"=>1}
    end
  end

  method :to_hash do
    test do
      h = {:a=>1, :b=>2}
      h.to_hash.assert == h
    end
  end

end

test_case Enumerable do

  method :to_h do
    test do
      (1..4).to_h.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_auto do
    test do
      (1..4).to_h_auto.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_splat do
    test do
      (1..4).to_h_splat.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_flat do
    test do
      (1..4).to_h_flat.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_assoc do
    test do
      (1..4).to_h_assoc.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
    end
  end

  method :to_h_multi do
    test do
      (1..4).to_h_multi.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
    end
  end

  #method :to_hash do
  #  test do
  #    (1..4).to_hash.assert == { 1=>2, 3=>4 }
  #  end
  #end
end

test_case Enumerator do

  method :to_h do
    test do
      (1..4).to_enum.to_h.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_auto do
    test do
      (1..4).to_enum.to_h_auto.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_splat do
    test do
      (1..4).to_enum.to_h_splat.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_flat do
    test do
      (1..4).to_enum.to_h_flat.assert == { 1=>2, 3=>4 }
    end
  end

  method :to_h_assoc do
    test do
      (1..4).to_enum.to_h_assoc.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
    end
  end

  method :to_h_multi do
    test do
      (1..4).to_enum.to_h_multi.assert == { 1=>[], 2=>[], 3=>[], 4=>[] }
    end
  end

  #method :to_hash do
  #  test do
  #    (1..4).to_hash.assert == { 1=>2, 3=>4 }
  #  end
  #end
end

test_case Struct do

  method :to_h do
    test do
      s = Struct.new(:a,:b).new(1,2)
      s.to_h.assert == {:a=>1, :b=>2}
    end
  end

end

test_case NilClass do

  method :to_h do
    test do
      nil.to_h.assert == {}
    end
  end

end
