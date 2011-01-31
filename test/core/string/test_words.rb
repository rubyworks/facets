covers 'facets/string/words'

testcase String do

  unit :words do
    x = "a b c\nd e"
    x.words.assert == ['a','b','c','d','e']

    x = "ab cd\nef"
    x.words.assert == ['ab','cd','ef']
  end

  unit :words do
    x = "ab cd \n ef-gh"
    x.words.assert == ['ab','cd','ef-gh']
  end

end
