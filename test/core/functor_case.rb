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

end

