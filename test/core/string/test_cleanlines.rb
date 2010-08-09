Covers 'facets/string/cleanlines'

Case String do

  Unit :cleanlines do
    "a \n b \nc".cleanlines.to_a.assert == ["a","b","c"]
  end

end

