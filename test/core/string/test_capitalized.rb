covers 'facets/string/capitalized'

testcase String do

  unit :capitalized? do
    'Abc'.assert.capitalized?
  end

  unit :downcase? do
    'abc'.assert.downcase?
  end

  unit :upcase? do
    'ABC'.assert.upcase?
  end

  #unit :lowercase? do
  #  'abc'.assert.lowercase?
  #end

  #unit :uppercase? do
  #  'ABC'.assert.uppercase?
  #end

end

