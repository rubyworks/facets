covers 'facets/string/variablize'

testcase String do

  unit :variablize do
    s = "a"
    s.variablize.assert == "@a"
  end

end

