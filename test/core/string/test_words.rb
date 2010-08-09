Covers 'facets/string/words'

Case String do

  Unit :words do
    x = "a b c\nd e"
    x.words.assert == ['a','b','c','d','e']

    x = "ab cd\nef"
    x.words.assert == ['ab','cd','ef']
  end

  Unit :words do
    x = "ab cd \n ef-gh"
    x.words.assert == ['ab','cd','ef-gh']
  end

end
