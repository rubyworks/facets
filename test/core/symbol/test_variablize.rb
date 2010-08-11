Covers 'facets/symbol/variablize'

TestCase Symbol do

  unit :variablize do
    :a.variablize.assert == "@a".to_sym
  end

end

