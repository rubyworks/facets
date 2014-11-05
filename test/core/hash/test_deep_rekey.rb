covers 'facets/hash/deep_rekey'

test_case Hash do

  method :deep_rekey do

    test "default converts all keys to symbols" do
      foo = { "c"=>{ "a"=>1, "b"=>2 } }
      foo.deep_rekey.assert == { :c=>{ :a=>1, :b=>2 } }
      foo.assert == { "c"=>{ "a"=>1, "b"=>2 } }
    end

    test "specific key" do
      bar = { :d=>{ :a=>1, :b=>2 } }
      foo = bar.deep_rekey(:a=>:c)
      foo[:d][:c].assert == 1
      foo[:d][:b].assert == 2
      foo[:d][:a].assert == nil
    end

    test "multiple keys" do
      bar = { :z=>{ :a=>1, :b=>2, :c=>3 } }
      foo = bar.deep_rekey(:a=>:d,:b=>:e)
      foo[:z][:d].assert == 1
      foo[:z][:e].assert == 2
      foo[:z][:c].assert == 3
      foo[:z][:a].assert == nil
      foo[:z][:b].assert == nil
    end

    test "multiple keys, some on same level as other hash" do
      bar = { :z=>{ :a=>1, :b=>2, :c=>3 }, :y=>4 }
      foo = bar.deep_rekey(:a=>:d,:b=>:e)
      foo[:z][:d].assert == 1
      foo[:z][:e].assert == 2
      foo[:z][:c].assert == 3
      foo[:y].assert == 4
      foo[:z][:a].assert == nil
      foo[:z][:b].assert == nil
    end

    # TODO: Is using Hash#deep_rekey to exhange keys possible?

    #test "exchange keys via dummy key" do
    #  bar = { :a=>1, :b=>2, :c=>3 }
    #  foo = bar.deep_rekey(:a=>:d,:c=>:a,:d=>:c)
    #  foo[:a].assert == 3
    #  foo[:b].assert == 2
    #  foo[:c].assert == 1
    #  foo[:d].assert == nil
    #end

    test "with block" do
      bar = { :c=>{ :a=>1, :b=>2 } }
      foo = bar.deep_rekey{ |k| k.to_s }
      foo['c']['a'].assert == 1
      foo['c']['b'].assert == 2
      foo['c'][:a].assert  == nil
      foo['c'][:b].assert  == nil
      foo.assert == { 'c'=>{ 'a'=>1, 'b'=>2 } }
    end

    test "with block of key, value" do
      bar = { :c=>{ :a=>1, :b=>2 } }
      foo = bar.deep_rekey{ |k, v| v.to_s }
      k = foo.keys.first
      foo[k]['1'].assert == 1
      foo[k]['2'].assert == 2
      foo[k][:a].assert  == nil
      foo[k][:b].assert  == nil
      foo[k]['a'].assert  == nil
      foo[k]['b'].assert  == nil
      foo.assert == { k=>{ '1'=>1, '2'=>2 } }
    end

    test "with keys and block" do
      expect ArgumentError do
        bar = { :c=>{ :a=>1, :b=>2 } }
        bar.deep_rekey(:a=>:c){ |k| k.to_s }
      end
    end

    test "symbol proc" do
      foo = { :c=>{ :a=>1, :b=>2 } }
      foo.deep_rekey(&:to_s).assert == { "c"=>{ "a"=>1, "b"=>2 } }
      foo.assert == { :c=>{ :a =>1, :b=>2 } }
    end

  end

  method :deep_rekey! do

    test "default" do
      foo = { "c"=>{ "a"=>1, "b"=>2 } }
      foo.deep_rekey!.assert == { :c=>{ :a=>1, :b=>2 } }
      foo.assert == { :c=>{ :a=>1, :b=>2 } }
    end

    test "specific key" do
      foo = { :d=>{ :a=>1, :b=>2 } }
      foo.deep_rekey!(:a=>:c)
      foo[:d][:c].assert == 1
      foo[:d][:b].assert == 2
      foo[:d][:a].assert == nil
    end

    test "with block" do
      foo = { :c=>{ :a=>1, :b=>2 } }
      foo.deep_rekey!{ |k| k.to_s }
      foo['c']['a'].assert == 1
      foo['c']['b'].assert == 2
      foo['c'][:a].assert  == nil
      foo['c'][:b].assert  == nil
      foo.assert == { 'c'=>{ 'a'=>1, 'b'=>2 } }
    end

    test "symbol proc" do
      foo = { :c=>{ :a=>1, :b=>2 } }
      foo.deep_rekey!(&:to_s).assert == { "c"=>{ "a"=>1, "b"=>2 } }
      foo.assert == { "c"=>{ "a"=>1, "b"=>2 } }
    end

    test "no conflict between keys" do
      r = { 0 => {1 => :a, 2 => :b} }.deep_rekey!{ |k| k + 1 }
      r[1].refute = {3 => :a}
      r[1].assert = {2 => :a, 3 => :b}
    end

  end

end
