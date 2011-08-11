covers 'facets/string/lowercase'

test_case String do

  method :lowercase do

    test do
      "Bob".lowercase.assert == "bob"
    end

    test do
      "BOB".lowercase.assert == "bOB"
    end

  end

end

