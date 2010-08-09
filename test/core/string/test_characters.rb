Covers 'facets/string/characters'

Case String do

  Unit :characters do
    "abc".characters.assert == ["a","b","c"]
    "ab\nc".characters.assert == ["a","b","\n","c"]
  end

end

