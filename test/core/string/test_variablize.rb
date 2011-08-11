covers 'facets/string/variablize'

test_case String do

  method :variablize do

    test do
      s = "a"
      s.variablize.assert == "@a"
    end

  end

end

