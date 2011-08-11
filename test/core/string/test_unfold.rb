covers 'facets/string/unfold'

test_case String do

  method :unfold do

    test do
      str = "This is a test of\nparagraph folding."
      res = str.unfold
      exp = "This is a test of paragraph folding."
      res.assert == exp
    end

  end

end

