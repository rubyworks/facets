require 'facets/string/end_with'

Case String do

  Case :end_with? do
    s = "xxboo"
    s.assert.end_with?('boo')
  end

end

