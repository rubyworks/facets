covers 'facets/array/median'

testcase Array do

  unit :median do
    r = %w{a a b b c c c d}.median
    r.assert == "b"
  end

end
