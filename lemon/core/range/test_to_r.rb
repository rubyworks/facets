require 'facets/range/to_r'

Case Range do

  Unit :to_r do
    a = (0..10)
    a.to_r.assert == a
  end

  Unit :to_range do
    a = (0..10)
    a.to_range.assert == a
  end

end

