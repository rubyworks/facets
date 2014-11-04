require 'facets/math/gcd'
require 'facets/math/factorial'

test_case Math do

  class_method :gcd do
    test do
      Math.gcd(4732, 4700).assert == 4
      Math.gcd(3651, 5023).assert == 1
      Math.gcd(612221610, 67461255771).assert == 5565651
    end

    test "on a factorial" do
      Math.factorial(47).assert == Math.gcd(Math.factorial(90), Math.factorial(47))
    end
  end

end
