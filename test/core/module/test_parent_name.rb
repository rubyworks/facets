covers 'facets/module/parent_name'

testcase Module do

  unit :parent_name do
    Lemon::TestCase.parent_name.assert == "Lemon"
  end

end

