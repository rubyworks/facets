require 'facets/symbol/plain'
require 'test/unit'

class TC_Symbol_Plain < Test::Unit::TestCase

  def test_plain?
    assert(:try.plain? )

    assert( ! :try=.plain? )
    assert( ! :try?.plain? )
  end

end

