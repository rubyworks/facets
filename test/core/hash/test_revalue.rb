covers 'facets/hash/revalue'

test_case Hash do

  method :revalue do

    #test "default converts all keys to symbols" do
    #  foo = { "a"=>1, "b"=>2 }
    #  foo.rekey.assert == { :a=>1, :b=>2 }
    #  foo.assert == { "a"=>1, "b"=>2 }
    #end

    test "specific value" do
      bar = { :a=>1, :b=>2 }
      foo = bar.revalue(2=>3)
      foo[:a].assert == 1
      foo[:b].assert == 3
      foo.size.assert == 2
    end

    test "multiple values" do
      bar = { :a=>1, :b=>2, :c=>3 }
      foo = bar.revalue(1=>4,3=>5)
      foo[:a].assert == 4
      foo[:b].assert == 2
      foo[:c].assert == 5
      foo.size.assert == 3
    end

    test "with block" do
      bar = { :a=>1, :b=>2 }
      foo = bar.revalue{ |v| v.to_s }
      foo[:a].assert == "1"
      foo[:b].assert == "2"
      foo.assert == { :a=>"1", :b=>"2" }
    end

    test "with block of key, value" do
      bar = { :a=>1, :b=>2 }
      foo = bar.revalue{ |k, v| [k,v] }
      foo[:a].assert == [:a,1]
      foo[:b].assert == [:b,2]
      foo.assert == { :a=>[:a,1], :b=>[:b,2] }
    end

    test "with values and block" do
      expect ArgumentError do
        bar = { :a=>1, :b=>2 }
        bar.revalue(1=>3){ |v| v.to_s }
      end
    end

    test "symbol proc" do
      foo = { :a=>1, :b=>2 }
      foo.revalue(&:to_s).assert == { :a=>"1", :b=>"2" }
      foo.assert == { :a =>1, :b=>2 }
    end

  end

  method :revalue! do

    #test "default" do
    #  foo = { "a"=>1, "b"=>2 }
    #  foo.revalue!.assert == { :a=>1, :b=>2 }
    #  foo.assert == { :a=>1, :b=>2 }
    #end

    test "specific value" do
      foo = { :a=>1, :b=>2 }
      foo.revalue!(1=>3)
      foo[:a].assert == 3
      foo[:b].assert == 2
    end

    test "with block" do
      foo = { :a=>1, :b=>2 }
      foo.revalue!{ |v| v.to_s }
      foo[:a].assert == "1"
      foo[:b].assert == "2"
      foo.assert == { :a=>"1", :b=>"2" }
    end

    test "symbol proc" do
      foo = { :a=>1, :b=>2 }
      foo.revalue!(&:to_s).assert == { :a=>"1", :b=>"2" }
      foo.assert == { :a=>"1", :b=>"2" }
    end

    test "no conflict between keys" do
      r = {:a => 1, :b => 2}.revalue!{ |v| v + 1 }
      r.refute = {:a => 3}
      r.assert = {:a => 2, :b => 3}  
    end

  end

end
