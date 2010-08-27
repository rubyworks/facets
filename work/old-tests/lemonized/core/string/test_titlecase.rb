require 'facets/string/titlecase.rb'
require 'test/unit'

class StringTitleCaseTest < Test::Unit::TestCase

  def test_titlecase
    r = "try this out".titlecase
    x = "Try This Out"
    assert_equal(x,r)
  end

end

