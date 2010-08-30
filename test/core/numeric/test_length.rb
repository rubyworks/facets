covers 'facets/numeric/length'

testcase Numeric do

  unit :length do
    (0..10).each do |power|
      power.length.assert == power
    end
  end

end

