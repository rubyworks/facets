covers 'facets/string/end_with'

tests String do

  unit :end_with? do
    s = "xxboo"
    s.assert.end_with?('boo')
  end

  unit :ends_with? do
    s = "xxboo"
    s.assert.ends_with?('boo')
  end

end

