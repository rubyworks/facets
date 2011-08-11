covers 'facets/functor'

test_case Functor do

  class_method :new do

    test do
      fc = Functor.new do |op, *a, &b|
        [op, a, b]
      end
      (fc + 1).assert == [:+, [1], nil]
    end

  end

  method :__class__ do

    test do
      fc = Functor.new do |op, *a, &b|
        [op, a, b]
      end
      fc.__class__.assert == Functor
    end

  end

  method :to_proc do

    test do
      f = Functor.new do |op, *a|
        [op, *a]
      end
      p = f.to_proc
      p.assert.is_a? Proc
      p.call(:+,1,2,3).assert == [:+,1,2,3]
    end

  end

end

