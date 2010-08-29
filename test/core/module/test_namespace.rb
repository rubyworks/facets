covers 'facets/module/parent_name'

tests Module do

  unit :parent_name do
    Lemon::TestCase.parent_name.assert == "Lemon"
  end

end

