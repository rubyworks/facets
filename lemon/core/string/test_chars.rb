require 'facets/string/chars'

Case String do

  Unit :chars do
    "abc".chars.assert == ["a","b","c"]
    "ab\nc".chars.assert == ["a","b","\n","c"]
  end

end

