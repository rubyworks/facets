covers 'facets/string/unquote'

test_case String do

  method :unquote do

    test do
      "'here'".unquote.assert == "here"
    end

  end

end
