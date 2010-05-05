Covers 'facets/string/line_wrap'

Case String do

  Unit :line_wrap do
    "abc123".line_wrap(3).assert == "abc\n123\n"
    "abcd123".line_wrap(4).assert == "abcd\n123\n"
  end

end

