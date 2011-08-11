covers 'facets/module/methodize'

test_case Module do

  method :methodize do

    test do
      Lemon.methodize.assert == 'lemon'
    end

  end

end

test_case Class do

  method :methodize do

    test do
      Lemon::TestCase.methodize.assert == 'lemon__test_case'
    end

  end

end

