covers 'facets/string/similarity'

testcase String do

  unit :similarity do
    "Alexsander".similarity("Aleksander").assert == 0.9
  end

end

