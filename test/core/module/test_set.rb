covers 'facets/module/set'

test_case Module do

  method :set do

    test do
      c = Class.new do
        set :x, 10
      end

      c.x.assert == 10
    end

    test do
      h = 1
      c = Class.new do
        set :x do 
          h += 1
        end
      end

      c.x.assert == 2
      c.x.assert == 3
      c.x.assert == 4
    end

  end

end
