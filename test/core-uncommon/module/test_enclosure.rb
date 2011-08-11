covers 'facets/module/enclosure'
covers 'facets/module/enclosures'

test_case Module do

  method :enclosure do
    test do
      Lemon::TestCase.enclosure.assert == Lemon
    end

    test "anonymous module" do
      m = Module.new
      m.enclosure.assert == Object
    end
  end

  method :enclosures do
    test do
      Lemon::TestCase.enclosures.assert == [Lemon, Object]
    end
  end

end

