covers 'facets/string/store'

testcase String do

  unit :store do
    a = "HELLO"
    a.store(1, "X")
    a.assert == "HXLLO"
  end

end

