Covers 'facets/hash/rekey'

Case Hash do

  Unit :rekey => "specific key" do
    bar = { :a=>1, :b=>2 }
    foo = bar.rekey(:c, :a)
    foo[:c].assert == 1
    foo[:b].assert == 2
    foo[:a].assert == nil
  end

  Unit :rekey! => "specific key" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!(:c, :a)
    foo[:c].assert == 1
    foo[:b].assert == 2
    foo[:a].assert == nil
  end

  Unit :rekey => "with block" do
    bar = { :a=>1, :b=>2 }
    foo = bar.rekey{ |k| k.to_s }
    foo['a'].assert == 1
    foo['b'].assert == 2
    foo[:a].assert  == nil
    foo[:b].assert  == nil
    foo.assert == { 'a'=>1, 'b'=>2 }
  end

  Unit :rekey! => "with block" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!{ |k| k.to_s }
    foo['a'].assert == 1
    foo['b'].assert == 2
    foo[:a].assert == nil
    foo[:b].assert == nil
    foo.assert == { 'a'=>1, 'b'=>2 }
  end

  Unit :rekey => "symbol argument" do
    foo = { :a=>1, :b=>2 }
    foo.rekey(:to_s).assert == { "a"=>1, "b"=>2 }
    foo.assert == { :a =>1, :b=>2 }
  end

  Unit :rekey! => "symbol argument" do
    foo = { :a=>1, :b=>2 }
    foo.rekey!(:to_s).assert == { "a"=>1, "b"=>2 }
    foo.assert == { "a"=>1, "b"=>2 }
  end

  Unit :rekey => "default" do
    foo = { "a"=>1, "b"=>2 }
    foo.rekey!.assert == { :a=>1, :b=>2 }
    foo.assert == { :a=>1, :b=>2 }
  end

  Unit :rekey! => "default" do
    foo = { "a"=>1, "b"=>2 }
    foo.rekey!.assert == { :a=>1, :b=>2 }
    foo.assert == { :a=>1, :b=>2 }
  end

end

