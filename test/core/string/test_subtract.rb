covers 'facets/string/subtract'

testcase String do

  unit :- do
    ("foobar" - "oo").assert == "fbar"
    ("pizza pizza!" - "zz").assert == "pia pia!"
    ("letters" - /[a-z]+/).assert == ""
  end

end

