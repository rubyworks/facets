covers 'facets/class/subclasses'

test_case Class do

  method :subclasses do

    # class with a number of subclasses
    c = Class.new
    x = Class.new(c)
    y = Class.new(c)
    z = Class.new(c)

    test do
      c.subclasses == [x, y, z]
    end

  end

end

