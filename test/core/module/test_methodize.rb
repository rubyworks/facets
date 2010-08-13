covers 'facets/module/methodize'

tests Module do

  unit :methodize do
    Lemon.methodize.assert == 'lemon'
  end

end

tests Class do

  unit :methodize do
    Lemon::TestCase.methodize.assert == 'lemon__test_case'
  end

end

