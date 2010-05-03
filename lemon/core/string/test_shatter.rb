require 'facets/string/shatter'

Case String do

  Unit :shatter do
    s = "<p>This<b>is</b>a test.</p>"
    r = s.shatter( /<.*?>/ )
    x = ["<p>", "This", "<b>", "is", "</b>", "a test.", "</p>"]
    r.assert == x
  end

end

