require 'facets/functor'

TestCase Functor do

  metaunit :new do
    fc = Functor.new do |op, *a, &b|
      [op, a, b]
    end
    (fc + 1).assert == [:+, [1], nil]
  end

end

