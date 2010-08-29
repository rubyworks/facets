covers 'facets/module/enclosures'

tests Module do

  unit :enclosures do
    Lemon::TestCase.enclosures.assert == [Lemon, Object]
  end

end

