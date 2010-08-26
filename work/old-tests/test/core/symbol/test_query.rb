require 'facets/symbol/query'
require 'test/unit'

class TC_Symbol_Query < Test::Unit::TestCase

  def test_query?
    assert( :try?.query? )

    assert( ! :try.query? )
    assert( ! :try=.query? )
  end

end

