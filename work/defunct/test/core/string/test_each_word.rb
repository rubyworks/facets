require 'facets/string/each_word.rb'
require 'test/unit'

class Test_String_EachWord < Test::Unit::TestCase

  def test_each_word
    a = []
    i = "this is a test"
    i.each_word{ |w| a << w }
    assert_equal( ['this', 'is', 'a', 'test'], a )
  end

end

