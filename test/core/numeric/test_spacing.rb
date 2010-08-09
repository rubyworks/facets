Covers 'facets/numeric/spacing'

Case Numeric do

  Unit :spacing do
    samples = [-10.5, -3, 3, 1.0e14, 10000, 14.5e10]
    samples.each do |numeric_item|
      numeric_item.spacing.assert == numeric_item.to_s.size
      numeric_item.spacing.assert.kind_of?(Integer)
    end
  end

end
