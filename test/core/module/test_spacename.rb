covers 'facets/module/spacename'

tests Module do

  unit :spacename do
    Lemon::TestCase.spacename.assert == 'Lemon'
    Lemon.spacename.assert == ''  # should this be nil ?
  end

end

