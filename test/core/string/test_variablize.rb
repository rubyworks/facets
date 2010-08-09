Covers 'facets/string/variablize'

Case String do

  Unit :variablize do
    s = "a"
    s.variablize.assert == "@a"
  end

end

