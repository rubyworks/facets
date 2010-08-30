covers 'facets/array/entropy'

testcase Array do

  unit :entropy do
    %w{ a b }.entropy.assert == 1.0
  end

  unit :ideal_entropy do
    %w{ a b }.ideal_entropy.assert == 1.0
    %w{ a a b b }.ideal_entropy.assert == 2.0
  end

end

