covers 'facets/string/lchomp'

testcase String do

  unit :lchomp do
    s = "xxboo"
    r = s.lchomp("xx")
    r.assert == "boo"
  end

  unit :lchomp! do
    s = "xxboo"
    s.lchomp!("xx")
    s.assert == "boo"
  end

end
