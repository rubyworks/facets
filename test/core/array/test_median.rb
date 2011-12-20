covers 'facets/array/median'

test_case Array do

  method :median do
    test do
      r = %w{a a b b c c c d}.median
      r.assert == "b"
    end
  end

end
