covers 'facets/module/basename'

tests Module do

  unit :basename do
    Lemon::TestCase.basename.assert == "TestCase"
  end

end

