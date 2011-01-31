covers 'facets/symbol/variablize'

testcase Symbol do

  unit :variablize do
    :a.variablize.assert == "@a".to_sym
  end

end

