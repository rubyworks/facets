covers 'facets/enumerator'

test_case Enumerator::Yielder do

  class_method :new do

    test do
      y = Enumerator::Yielder.new{ |x| x + 1 }
    end

  end

  method :yield do

    test do
      y = Enumerator::Yielder.new{ |x| x + 1 }
      y.yield(1).assert == 2
    end

  end

  method :<< do

    test do
      a = []
      y = Enumerator::Yielder.new{ |x| a << x + 1 }
      y << 1
      a.assert == [2]
    end

    test do
      a = []
      y = Enumerator::Yielder.new{ |x,y| a << x + y }
      y.<<(1,2)
      a.assert == [3]
    end

  end

end
