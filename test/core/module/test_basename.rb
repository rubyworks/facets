covers 'facets/module/basename.rb'

tests Module do

  unit :basename do
    Lemon::TestCase.basename.assert == "Lemon"
  end

end

