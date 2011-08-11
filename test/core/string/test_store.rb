covers 'facets/string/store'

test_case String do

  method :store do

    test do
      a = "HELLO"
      a.store(1, "X")
      a.assert == "HXLLO"
    end

  end

end

