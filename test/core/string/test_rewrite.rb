covers 'facets/string/rewrite'

test_case String do

  method :rewrite do

    test do
      s = "HELLO TOMMY!"
      rules = [[ /TOMMY/, 'MAN' ]]
      r = s.rewrite(rules)
      r.assert == "HELLO MAN!"
    end

  end

end

