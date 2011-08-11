covers 'facets/module/pathize'

test_case Module do

  method :pathize do

    test do
      Lemon.pathize.assert == 'lemon'
    end

  end

end

test_case Class do

  method :pathize do

    test do
      Lemon::TestCase.pathize.assert == 'lemon/test_case'
    end

  end

end
