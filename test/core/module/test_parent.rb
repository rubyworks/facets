covers 'facets/module/parent'

tests Module do

  unit :parent do
    Lemon::TestCase.parent.assert == Lemon
  end

end

