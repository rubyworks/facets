covers 'facets/string/file'

test_case String do

  method :file do

    test do
      "home/trans".file.dirname.assert == "home"
      "home/trans".file.basename.assert == "trans"
    end

  end

end

