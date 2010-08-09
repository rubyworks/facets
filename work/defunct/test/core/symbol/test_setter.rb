require 'facets/symbol/setter'
require 'test/unit'

class TC_Symbol_Setter < Test::Unit::TestCase

  def test_setter?
    assert( :try=.setter? )

    assert( ! :try.setter? )
    assert( ! :try?.setter? )
  end

end

