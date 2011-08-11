covers 'facets/string/divide'

test_case String do

  method :divide do

    test do
      s = "<p>This<b>is</b>a test.</p>"
      d = s.divide( /<.*?>/ )
      e = ["<p>This", "<b>is", "</b>a test.", "</p>"]
      d.assert == e
    end

  end

end

