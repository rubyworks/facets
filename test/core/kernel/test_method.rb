covers 'facets/kernel/method'

test_case Kernel do

  method :method! do

    test do
      c = Class.new do
        def foo ; 'foo' ; end
      end

      ic = c.new
      ic.method(:foo).__id__.refute == ic.method(:foo).__id__
      ic.method!(:foo).__id__.assert == ic.method!(:foo).__id__
    end

  end

end

