require 'facets/integer/length'
require 'test/unit'


class TC_Integer < Test::Unit::TestCase
  def test_length
    (0..10).each do |power|
      assert((10 ** power).length == (power + 1))
    end
  end
end

