covers 'facets/regexp/op_or'

tests Regexp do

  unit :| do
    re = /a/ | /b/
    re.assert =~ "a"
    re.assert =~ "b"
  end

end

