covers 'facets/string/line_wrap'

test_case String do

  method :line_wrap do

    test do
      "abc123".line_wrap(3).assert == "abc\n123\n"
      "abcd123".line_wrap(4).assert == "abcd\n123\n"
    end

  end

end

