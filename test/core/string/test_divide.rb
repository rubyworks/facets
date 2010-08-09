Covers 'facets/string/divide'

Case String do

  Unit :divide do
    s = "<p>This<b>is</b>a test.</p>"
    d = s.divide( /<.*?>/ )
    e = ["<p>This", "<b>is", "</b>a test.", "</p>"]
    d.assert == e
  end

end

