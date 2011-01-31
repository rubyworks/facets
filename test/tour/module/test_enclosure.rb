covers 'facets/module/enclosure'
covers 'facets/module/enclosures'

tests Module do

  unit :enclosure do
    Lemon::TestCase.enclosure.assert == Lemon
  end

  unit :enclosure => "anonymous module" do
    m = Module.new
    m.enclosure.assert == Object
  end

  unit :enclosures do
    Lemon::TestCase.enclosures.assert == [Lemon, Object]
  end

end

