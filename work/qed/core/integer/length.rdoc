Covers 'facets/integer/length'

Case Integer do

  Unit :length do
    (0..10).each do |power|
      (10 ** power).length.assert == power + 1
    end
  end

end

