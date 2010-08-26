require 'facets/hash/update_values'
require 'test/unit'

class TC_Hash_Update_Values < Test::Unit::TestCase

  def test_update_values
    h = { 1 => 'A', 2 => 'B' }
    h.update_values{ |v| v.downcase }
    assert_equal( { 1 => 'a', 2 => 'b' }, h )
  end

end
