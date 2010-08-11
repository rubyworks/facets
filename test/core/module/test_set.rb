covers 'facets/module/set'

tests Module do

  unit :set do
    c = Class.new do
      set :x, 10
    end

    c.x.assert == 10
  end

  unit :set do
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
