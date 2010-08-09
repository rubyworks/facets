require 'facets/hash/update_keys'
require 'test/unit'

class TC_Hash_Update_Keys < Test::Unit::TestCase

  def test_update_keys_01
    h = { 'A' => 1, 'B' => 2 }
    h.update_keys{ |k| k.downcase }
    assert_equal( { 'a' => 1, 'b' => 2 }, h)
  end

  def test_update_keys_02
    h = { :a => 1, :b => 2 }
    h.update_keys{ |k| "#{k}!" }
    assert_equal( { "a!" => 1, "b!" => 2 }, h)
  end

end
