covers 'facets/range/to_rng'

test_case Range do

  method :to_rng do
    test do
      a = (0..10)
      a.to_rng.assert == a
    end
  end

  method :to_range do
    test do
      a = (0..10)
      a.to_range.assert == a
    end
  end

end

