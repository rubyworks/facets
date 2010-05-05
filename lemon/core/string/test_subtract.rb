Covers 'facets/string/subtract'

Case String do

  Unit :subtract do
    ("foobar" - "oo").assert == "fbar"
    ("pizza pizza!" - "zz").assert == "pia pia!"
    ("letters" - /[a-z]+/).assert == ""
  end

end

