covers 'facets/string/unfold'

testcase String do

  unit :unfold do
    str = "This is a test of\nparagraph folding."
    res = str.unfold
    exp = "This is a test of paragraph folding."
    res.assert == exp
  end

end

