require 'facets/nilclass/to_f'
require 'test/unit'

class TC_NilClass_To_F < Test::Unit::TestCase

  def test_to_f
    assert_equal( 0, nil.to_f )
  end

end

