covers 'facets/string/titlecase'

testcase String do

  unit :titlecase do
    r = "try this out".titlecase
    x = "Try This Out"
    r.assert == x
  end

end

