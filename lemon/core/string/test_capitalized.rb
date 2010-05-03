require 'facets/string/capitalized'

Case String do

  Unit :capitalized? do
    'Abc'.assert.capitalized?
  end

  Unit :downcase? do
    'abc'.assert.downcase?
  end

  Unit :upcase? do
    'ABC'.assert.upcase?
  end

  #Unit :lowercase? do
  #  'abc'.assert.lowercase?
  #end

  #Unit :uppercase? do
  #  'ABC'.assert.uppercase?
  #end

end

