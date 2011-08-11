covers 'facets/module/alias_accessor'

test_case Module do

  method :alias_accessor do

    test do
      c = Class.new do
        attr_accessor :x
        alias_accessor :y, :x
      end

      x = c.new

      x.x = 10
      x.x.assert == 10
      x.y.assert == 10

      x.y = 20
      x.x.assert == 20
      x.y.assert == 20
    end

  end

end

