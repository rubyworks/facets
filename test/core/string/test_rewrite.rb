covers 'facets/string/rewrite'

testcase String do

  unit :rewrite do
    s = "HELLO TOMMY!"
    rules = [[ /TOMMY/, 'MAN' ]]
    r = s.rewrite(rules)
    r.assert == "HELLO MAN!"
  end

end

