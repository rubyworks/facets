Covers 'facets/string/lchomp'

Case String do

  Unit :lchomp do
    s = "xxboo"
    r = s.lchomp("xx")
    r.assert == "boo"
  end

  Unit :lchomp! do
    s = "xxboo"
    s.lchomp!("xx")
    s.assert == "boo"
  end

end
