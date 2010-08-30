covers 'facets/hash/rekey'

testcase Hash do

  unit :rekey => "default" do
    foo = { "a"=>1, "b"=>2 }
    foo.rekey.assert == { :a=>1, :b=>2 }
    foo.assert == { "a"=>1, "b"=>2 }
  end

  unit :rekey! => "default" do
    foo = { "a"=>1, "b"=>2 }
    foo.rekey!.assert == { :a=>1, :b=>2 }
    foo.assert == { :a=>1, :b=>2 }
  end

  unit :rekey => "specific key" do
    bar = { :a=>1, :b=>2 }
    foo = bar.rekey(:a=>:c)
    foo[:c].assert == 1
    foo[:b].assert == 2
    foo[:a].assert == nil
  end

  unit :rekey! => "specific key" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!(:a=>:c)
    foo[:c].assert == 1
    foo[:b].assert == 2
    foo[:a].assert == nil
  end

  unit :rekey => "with block" do
    bar = { :a=>1, :b=>2 }
    foo = bar.rekey{ |k| k.to_s }
    foo['a'].assert == 1
    foo['b'].assert == 2
    foo[:a].assert  == nil
    foo[:b].assert  == nil
    foo.assert == { 'a'=>1, 'b'=>2 }
  end

  unit :rekey! => "with block" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!{ |k| k.to_s }
    foo['a'].assert == 1
    foo['b'].assert == 2
    foo[:a].assert == nil
    foo[:b].assert == nil
    foo.assert == { 'a'=>1, 'b'=>2 }
  end

  unit :rekey => "symbol proc" do
    foo = { :a=>1, :b=>2 }
    foo.rekey(&:to_s).assert == { "a"=>1, "b"=>2 }
    foo.assert == { :a =>1, :b=>2 }
  end

  unit :rekey! => "symbol proc" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!(&:to_s).assert == { "a"=>1, "b"=>2 }
    foo.assert == { "a"=>1, "b"=>2 }
  end

  unit :rekey! => "no conflict between keys" do
    r = {1 => :a, 2 => :b}.rekey!{ |k| k + 1 }
    r.refute = {3 => :a}
    r.assert = {2 => :a, 3 => :b}  
  end

end
