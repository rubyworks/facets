covers 'facets/string/squish'

testcase String do

  unit :squish do
    r = %{ Multi-line
           string }.squish 
    r.assert == "Multi-line string"
  end

  unit :squish do
    r = " foo   bar    \n   \t   boo".squish
    r.assert == "foo bar boo"
  end

  unit :squish! do
    s = " foo   bar    \n   \t   boo"
    s.squish!
    s.assert == "foo bar boo"
  end

end

