covers 'facets/module/abstract'

test_case Module do

  method :abstract do

    test "in a module" do
      m = Module.new{ abstract :q }
      c = Class.new{ include m }
      x = c.new
      TypeError.assert.raised?{ x.q }
    end

    test "in a class" do
      c = Class.new{ abstract :q }
      #c.pry.abstract :q
      x = c.new
      TypeError.assert.raised?{ x.q }
    end

  end

end

