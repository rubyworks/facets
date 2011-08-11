covers 'facets/string/words'

test_case String do

  method :words do

    test do
      x = "a b c\nd e"
      x.words.assert == ['a','b','c','d','e']
    end

    test do
      x = "ab cd\nef"
      x.words.assert == ['ab','cd','ef']
    end

    test do
      x = "ab cd \n ef-gh"
      x.words.assert == ['ab','cd','ef-gh']
    end

  end

end
