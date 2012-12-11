covers 'facets/hash/rekey'

test_case Hash do

  method :rekey do

    test "default converts all keys to symbols" do
      foo = { "a"=>1, "b"=>2 }
      foo.rekey.assert == { :a=>1, :b=>2 }
      foo.assert == { "a"=>1, "b"=>2 }
    end

    test "specific key" do
      bar = { :a=>1, :b=>2 }
      foo = bar.rekey(:a=>:c)
      foo[:c].assert == 1
      foo[:b].assert == 2
      foo[:a].assert == nil
    end

    test "multiple keys" do
      bar = { :a=>1, :b=>2, :c=>3 }
      foo = bar.rekey(:a=>:d,:b=>:e)
      foo[:d].assert == 1
      foo[:e].assert == 2
      foo[:c].assert == 3
      foo[:a].assert == nil
      foo[:b].assert == nil
    end

    # TODO: Is using Hash#rekey to exhange keys possible?

    #test "exchange keys via dummy key" do
    #  bar = { :a=>1, :b=>2, :c=>3 }
    #  foo = bar.rekey(:a=>:d,:c=>:a,:d=>:c)
    #  foo[:a].assert == 3
    #  foo[:b].assert == 2
    #  foo[:c].assert == 1
    #  foo[:d].assert == nil
    #end

    test "with block" do
      bar = { :a=>1, :b=>2 }
      foo = bar.rekey{ |k| k.to_s }
      foo['a'].assert == 1
      foo['b'].assert == 2
      foo[:a].assert  == nil
      foo[:b].assert  == nil
      foo.assert == { 'a'=>1, 'b'=>2 }
    end

    test "with block of key, value" do
      bar = { :a=>1, :b=>2 }
      foo = bar.rekey{ |k, v| v.to_s }
      foo['1'].assert == 1
      foo['2'].assert == 2
      foo[:a].assert  == nil
      foo[:b].assert  == nil
      foo['a'].assert  == nil
      foo['b'].assert  == nil
      foo.assert == { '1'=>1, '2'=>2 }
    end

    test "with keys and block" do
      expect ArgumentError do
        bar = { :a=>1, :b=>2 }
        bar.rekey(:a=>:c){ |k| k.to_s }
      end
    end

    test "symbol proc" do
      foo = { :a=>1, :b=>2 }
      foo.rekey(&:to_s).assert == { "a"=>1, "b"=>2 }
      foo.assert == { :a =>1, :b=>2 }
    end

  end

  method :rekey! do

    test "default" do
      foo = { "a"=>1, "b"=>2 }
      foo.rekey!.assert == { :a=>1, :b=>2 }
      foo.assert == { :a=>1, :b=>2 }
    end

    test "specific key" do
      foo = { :a=>1, :b=>2 }
      foo.rekey!(:a=>:c)
      foo[:c].assert == 1
      foo[:b].assert == 2
      foo[:a].assert == nil
    end

    test "with block" do
      foo = { :a=>1, :b=>2 }
      foo.rekey!{ |k| k.to_s }
      foo['a'].assert == 1
      foo['b'].assert == 2
      foo[:a].assert == nil
      foo[:b].assert == nil
      foo.assert == { 'a'=>1, 'b'=>2 }
    end

    test "symbol proc" do
      foo = { :a=>1, :b=>2 }
      foo.rekey!(&:to_s).assert == { "a"=>1, "b"=>2 }
      foo.assert == { "a"=>1, "b"=>2 }
    end

    test "no conflict between keys" do
      r = {1 => :a, 2 => :b}.rekey!{ |k| k + 1 }
      r.refute = {3 => :a}
      r.assert = {2 => :a, 3 => :b}  
    end

  end

end
