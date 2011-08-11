covers 'facets/string/shatter'

test_case String do

  method :shatter do

    test do
      s = "<p>This<b>is</b>a test.</p>"
      r = s.shatter( /<.*?>/ )
      x = ["<p>", "This", "<b>", "is", "</b>", "a test.", "</p>"]
      r.assert == x
    end

  end

end

