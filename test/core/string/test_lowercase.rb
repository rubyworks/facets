Covers 'facets/string/lowercase'

TestCase String do

  unit :lowercase do
    "Bob".lowercase.assert == "bob"
  end

  unit :lowercase do
    "BOB".lowercase.assert == "bOB"
  end

end

