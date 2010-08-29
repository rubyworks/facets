covers 'facets/module/namespace'

tests Module do

  unit :namespace do
    Lemon::TestCase.namespace.assert == "Lemon"
  end

end
