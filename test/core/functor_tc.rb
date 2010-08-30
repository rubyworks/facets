covers 'facets/functor'

tests Functor do

  metaunit :new do
    fc = Functor.new do |op, *a, &b|
      [op, a, b]
    end
    (fc + 1).assert == [:+, [1], nil]
  end

  unit :__class__ do
    fc = Functor.new do |op, *a, &b|
      [op, a, b]
    end
    fc.__class__.assert == Functor
  end

  unit :to_proc do
    f = Functor.new do |op, *a|
      [op, *a]
    end
    p = f.to_proc
    p.assert.is_a? Proc
    p.call(:+,1,2,3).assert == [:+,1,2,3]
  end

end

