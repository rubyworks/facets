covers 'facets/string/cleanlines'

testcase String do

  unit :cleanlines do
    "a \n b \nc".cleanlines.to_a.assert == ["a","b","c"]
  end

end

