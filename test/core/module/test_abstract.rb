covers 'facets/module/abstract'

testcase Module do

  unit :abstract => "in a module" do
    m = Module.new{ abstract :q }
    c = Class.new{ include m }
    x = c.new
    TypeError.assert.raised?{ x.q }
  end

  unit :abstract => "in a class" do
    c = Class.new{ abstract :q }
    #c.pry.abstract :q
    x = c.new
    TypeError.assert.raised?{ x.q }
  end

end

