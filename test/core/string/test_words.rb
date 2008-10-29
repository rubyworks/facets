require 'facets/string/words.rb'
require 'test/unit'

class Test_String_Words < Test::Unit::TestCase

  def test_words_01
    x = "a b c\nd e"
    assert_equal( ['a','b','c','d','e'], x.words )
  end

  def test_words_02
    x = "ab cd\nef"
    assert_equal( ['ab','cd','ef'], x.words )
  end

  def test_words_03
    x = "ab cd \n ef-gh"
    assert_equal( ['ab','cd','ef-gh'], x.words )
  end

  #def test_word_filter
  #  s = "this is a test"
  #  n = s.word_filter{ |w| "#{w}1" }
  #  assert_equal( 'this1 is1 a1 test1', n )
  #end

  #def test_word_filter!
  #  s = "this is a test"
  #  s.word_filter!{ |w| "#{w}1" }
  #  assert_equal( 'this1 is1 a1 test1', s )
  #end

end
