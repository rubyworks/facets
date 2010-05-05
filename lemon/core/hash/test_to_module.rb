Covers 'facets/hash/to_module'

Case Hash do

  Unit :to_module do
    h = { :a=>1, :b=>2 }
    m = h.to_module
    Module.assert === m
  end

  Unit :to_module => "check methods" do
    h = { :a=>1, :b=>2 }
    m = h.to_module
    x = Class.new{ include m }.new
    x.a.assert == 1
    x.b.assert == 2
  end

end

