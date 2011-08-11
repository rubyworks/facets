covers 'facets/module/modname'

test_case Module do

  method :modname do

    test do
      Lemon::TestCase.modname.assert == "Lemon"
    end

  end

end
