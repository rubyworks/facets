require 'facets/uri'
require 'test/unit'

class TC_Uri < Test::Unit::TestCase

  def test_hash_to_query
    h = { :a=>1, :b=>2 }
    r = URI.hash_to_query(h)
    assert(r == "a=1;b=2" || r == "b=2;a=1")
  end

end


class TC_Kernel < Test::Unit::TestCase

  def test_uri
    assert_equal( uri("abc?xyz"), "abc%3Fxyz" )
  end

  def test_unuri
    assert_equal( unuri("abc%3Fxyz"), "abc?xyz" )
  end

end


class TC_Hash < Test::Unit::TestCase

  def test_to_uri
    h = { :a=>1, :b=>2 }
    r = h.to_uri
    assert(r == "a=1;b=2" || r == "b=2;a=1")
  end

end
