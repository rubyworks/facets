covers 'facets/module/basename'

test_case Module do

  method :basename do

    test do
      Lemon::TestCase.basename.assert == "TestCase"
    end

  end

end

