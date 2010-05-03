require 'facets/string/rewrite'

Case String do

  Unit :rewrite do
    s = "HELLO TOMMY!"
    rules = [[ /TOMMY/, 'MAN' ]]
    r = s.rewrite(rules)
    r.assert == "HELLO MAN!"
  end

end

