covers 'facets/range/to_r'

test_case Range do

  method :to_r do
    test do
      a = (0..10)
      a.to_r.assert == a
    end
  end

  method :to_range do
    test do
      a = (0..10)
      a.to_range.assert == a
    end
  end

end

