Covers 'facets/string/similarity'

TestCase String do

  Unit :similarity do
    "Alexsander".similarity("Aleksander").assert == 0.9
  end

end

