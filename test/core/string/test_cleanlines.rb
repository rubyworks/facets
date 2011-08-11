covers 'facets/string/cleanlines'

test_case String do

  method :cleanlines do
    test do
      "a \n b \nc".cleanlines.to_a.assert == ["a","b","c"]
    end
  end

end

