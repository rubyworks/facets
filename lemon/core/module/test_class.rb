Covers 'facets/module/class'

Case Module do

  Unit :class? do
    x_class = Class.new
    y_class = Class.new(x_class)

    x = x_class.new
    y = y_class.new

    x_class.assert.class?(x)
    y_class.assert.class?(y)
    y_class.assert.class?(y)
  end

end

