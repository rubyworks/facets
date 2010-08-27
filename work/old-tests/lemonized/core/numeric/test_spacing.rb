require 'facets/numeric/spacing'
require 'test/unit'
 
class TC_Numeric_spacing < Test::Unit::TestCase
  def test_spacing
    samples = [-10.5, -3, 3, 1.0e14, 10000, 14.5e10]
    samples.each do |numeric_item|
      assert numeric_item.to_s.size == numeric_item.spacing
      assert numeric_item.spacing.kind_of?(Integer)
    end
  end
end
