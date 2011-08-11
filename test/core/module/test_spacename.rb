covers 'facets/module/spacename'

test_case Module do

  method :spacename do

    test do
      Lemon::TestCase.spacename.assert == 'Lemon'
      Lemon.spacename.assert == ''  # should this be nil ?
    end

  end

end

