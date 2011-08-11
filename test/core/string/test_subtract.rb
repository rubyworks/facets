covers 'facets/string/subtract'

test_case String do

  method :- do

    test do
      ("foobar" - "oo").assert == "fbar"
      ("pizza pizza!" - "zz").assert == "pia pia!"
      ("letters" - /[a-z]+/).assert == ""
    end

  end

end

