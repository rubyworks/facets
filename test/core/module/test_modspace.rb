covers 'facets/module/modspace'

tests Module do

  unit :modspace do
    Lemon::TestCase.modspace.assert == Lemon
    Lemon.modspace.assert == Object
  end

end

