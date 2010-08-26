require 'facets/string/rewrite'
require 'test/unit'

class TC_String < Test::Unit::TestCase

  def test_rewrite
    s = "HELLO TOMMY!"
    rules = [[ /TOMMY/, 'MAN' ]]
    x = s.rewrite(rules)
    assert_equal("HELLO MAN!", x)
  end

end

