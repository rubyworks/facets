covers 'facets/method/composition'

test_case Method do

  c = Class.new do
    def f(x); x * 3; end
    def g(x); x + 1; end
  end

  method :* do

    test do
      x = c.new
      f = x.method(:f) * x.method(:g)
      f.call(1).assert == 6
    end

    test do
      x = c.new
      f = x.method(:g) * x.method(:f)
      f.call(1).assert == 4
    end

  end

  method :^ do

    test do
      x = c.new
      f = x.method(:f) ^ 3
      f.call(1).assert == 27
    end

    test do
      x = c.new
      f = x.method(:g) ^ 3
      f.call(1).assert == 4
    end

  end

end
