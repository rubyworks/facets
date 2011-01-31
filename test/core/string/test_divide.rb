covers 'facets/string/divide'

testcase String do

  unit :divide do
    s = "<p>This<b>is</b>a test.</p>"
    d = s.divide( /<.*?>/ )
    e = ["<p>This", "<b>is", "</b>a test.", "</p>"]
    d.assert == e
  end

end

