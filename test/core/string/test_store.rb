Covers 'facets/string/store'

Case String do

  Unit :store do
    a = "HELLO"
    a.store(1, "X")
    a.assert == "HXLLO"
  end

end

