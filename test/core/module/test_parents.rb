covers 'facets/module/parents'

tests Module do

  unit :parents do
    Lemon::TestCase.parents.assert == [Lemon, Object]
  end

end

