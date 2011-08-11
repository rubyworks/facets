covers 'facets/array/entropy'

test_case Array do

  method :entropy do

    test do
      %w{ a b }.entropy.assert == 1.0
    end

  end

  method :ideal_entropy do

    test do
      %w{ a b }.ideal_entropy.assert == 1.0
      %w{ a a b b }.ideal_entropy.assert == 2.0
    end

  end

end

