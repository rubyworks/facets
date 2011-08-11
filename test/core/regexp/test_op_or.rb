covers 'facets/regexp/op_or'

test_case Regexp do

  method :| do

    test do
      re = /a/ | /b/
      re.assert =~ "a"
      re.assert =~ "b"
    end

  end

end

