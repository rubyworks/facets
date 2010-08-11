covers 'facets/module/parent'

testcase Module do

  unit :parent do
    Lemon::TestCase.parent.assert == Lemon
  end

end

