require 'facets/hash/update_each'
require 'test/unit'

class TC_Hash_Update_Each < Test::Unit::TestCase

  def test_update_each
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.update_each{ |k,v| { k => v+1 } }
    assert_equal( e, a )
  end

end
