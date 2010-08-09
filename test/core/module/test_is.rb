Covers 'facets/module/is'

Case Module do

  Unit :is? do
    m = Module.new
    x = Class.new
    y = Class.new(x) do
      is m
    end

    y.assert.is?(x)
    y.assert.is?(m)
  end

end

