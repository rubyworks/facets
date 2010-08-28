covers 'facets/array/percentile'

testcase Array do

  unit :percentile do
    r = %w{a a b b c c c d}.percentile(75)
    r.assert == "c"
  end

end
