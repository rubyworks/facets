require 'facets/symbol/not'
require 'test/unit'

class TestSymbolNot < Test::Unit::TestCase

  def test_not
    assert_equal( :"~a", ~:a )
    a = :a
    n = ~a
    assert( n.not? )
  end

end
