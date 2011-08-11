covers 'facets/numeric/length'

test_case Numeric do

  method :length do

    test do
      (0..10).each do |power|
        power.length.assert == power
      end
    end

  end

end

