covers 'facets/string/characters'

testcase String do

  unit :characters do
    "abc".characters.assert == ["a","b","c"]
    "ab\nc".characters.assert == ["a","b","\n","c"]
  end

end

