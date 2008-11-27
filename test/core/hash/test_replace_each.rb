require 'facets/hash/replace_each'
require 'test/unit'

class Test_Hash_Replace_Each < Test::Unit::TestCase

  def test_replace_each
    a = { :a => 1, :b => 2, :c => 3 }
    e = { :a => 2, :b => 3, :c => 4 }
    a.replace_each{ |k,v| { k => v+1 } }
    assert_equal( e, a )
  end

end

