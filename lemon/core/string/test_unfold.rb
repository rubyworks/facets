require 'facets/string/unfold'

Case String do

  Unit :unfold do
    str = "This is a test of\nparagraph folding."
    res = str.unfold
    exp = "This is a test of paragraph folding."
    res.assert == exp
  end

end

