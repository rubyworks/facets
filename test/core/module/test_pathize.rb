covers 'facets/module/pathize'

tests Module do

  unit :pathize do
    Lemon.pathize.assert == 'lemon'
  end

end

tests Class do

  unit :pathize do
    Lemon::TestCase.pathize.assert == 'lemon/test_case'
  end

end
