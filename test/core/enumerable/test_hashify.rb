covers 'facets/enumerable/hashify'

test_case Enumerable do
  method :hashify do
    test do
      a = [ [:a,1], [:b,2] ]
      a.hashify.class.assert == Enumerable::Hashifier
    end
  end
end

test_case Enumerable::Hashifier do
  method :splat do
    test do
      a = [1,2,3,4]
      h = Enumerable::Hashifier.new(a)
      h.splat.assert == {1 => 2, 3 => 4}
    end

    test do
      a = [1,2,3,4,5]
      h = Enumerable::Hashifier.new(a)
      h.splat.assert == {1 => 2, 3 => 4, 5=> nil}
    end

    test do
      a = 1..5
      h = Enumerable::Hashifier.new(a)
      h.splat.assert == {1 => 2, 3 => 4, 5=> nil}
    end
  end

  method :flat do
    test do
      a = [:a,1,[:b,2,:c],4]
      h = Enumerable::Hashifier.new(a)
      h.flat.assert == {a: 1, b: 2, c: 4}
    end

    test do
      a = [:a,1,[:b,2,:c]]
      h = Enumerable::Hashifier.new(a)
      h.flat.assert == {a: 1, b: 2, c: nil}
    end

    test do
      require 'set'
      a = Set.new([:a, 1, [:b, 2, :c]])
      h = Enumerable::Hashifier.new(a)
      h.flat.assert == {a: 1, b: 2, c: nil}
    end
  end

  method :associate do
    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.hashify.associate.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end

    test do
      a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
      a.hashify.associate.assert == { :x=>[4] }
    end
  end

  method :merge do
    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.hashify.merge.assert == { :a=>1, :b=>2, :c=>nil, :d=>nil }
    end

    test do
      a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
      a.hashify.merge.assert == { :x=>4 }
    end
  end

  method :concat do
    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.hashify.concat.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end

    test do
      a = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
      a.hashify.concat.assert == { :a=>[1,2,3,4] }
    end
  end

  method :by_index do
    test do
      [:a,:b,:c].hashify.by_index.assert == {0=>:a, 1=>:b, 2=>:c}
    end
  end

  method :auto do
    test do
      a = [ [:a,1], [:b,2] ]
      a.hashify.auto.assert == { :a=>1, :b=>2 }
    end

    test do
      a = [ [:a,1,2], [:b,2], [:c], [:d] ]
      a.hashify.auto.assert == { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    end

    test do
      a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
      a.hashify.auto.assert =={ [:a,1,2]=>2, :b=>[:c,3], 9=>nil }
    end

  end
end
