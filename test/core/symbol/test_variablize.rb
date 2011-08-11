covers 'facets/symbol/variablize'

test_case Symbol do

  method :variablize do

    test do
      :a.variablize.assert == "@a".to_sym
    end

  end

end

