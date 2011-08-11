covers 'facets/array/percentile'

test_case Array do

  method :percentile do
    test do
      r = %w{a a b b c c c d}.percentile(75)
      r.assert == "c"
    end
  end

end
