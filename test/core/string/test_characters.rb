covers 'facets/string/characters'

test_case String do

  method :characters do
    test do
      "abc".characters.assert == ["a","b","c"]
      "ab\nc".characters.assert == ["a","b","\n","c"]
    end
  end

end

