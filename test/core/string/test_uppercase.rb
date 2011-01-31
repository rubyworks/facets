covers 'facets/string/uppercase'

testcase String do

  unit :uppercase do
    "bob".uppercase.assert == "Bob"
  end

  unit :uppercase do
    "boB".uppercase.assert == "BoB"
  end

  unit :uppercase do
    "BoB".uppercase.assert == "BoB"
  end

end

