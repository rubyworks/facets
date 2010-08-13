covers 'facets/string/start_with'

tests String do

  unit :start_with? do
    s = "xxboo"
    s.assert.start_with?('xx')
  end

  unit :starts_with? do
    s = "xxboo"
    s.assert.starts_with?('xx')
  end

end

