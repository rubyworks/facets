Covers 'facets/numeric/length'

Case Numeric do

  Unit :length do
    (0..10).each do |power|
      power.length.assert == power
    end
  end

end

