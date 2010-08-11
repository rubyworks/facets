covers 'facets/module/parents'

testcase Module do

  unit :parents do
    Lemon::TestCase.parents.assert == [Lemon, Object]
  end

end

