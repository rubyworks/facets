require 'facets/string/start_with'

Case String do

  Unit :start_with? do
    s = "xxboo"
    s.assert.start_with?('xx')
  end

end

