covers 'facets/string/uppercase'

test_case String do

  method :uppercase do

    test do
      "bob".uppercase.assert == "Bob"
    end

    test do
      "boB".uppercase.assert == "BoB"
    end

    test do
      "BoB".uppercase.assert == "BoB"
    end

  end

end

