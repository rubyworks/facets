require 'facets/math/factorial'

test_case Math do

  class_method :factorial do
    fac = 1
    1.upto(100) do |i|
      fac *= i
      Math.factorial(i).assert == fac
    end
  end

end
