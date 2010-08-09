Covers 'facets/string/end_with'

Case String do

  Unit :end_with? do
    s = "xxboo"
    s.assert.end_with?('boo')
  end

end

