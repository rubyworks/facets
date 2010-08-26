require 'facets/string/word_wrap.rb'
require 'test/unit'

class Test_String_WordWrap < Test::Unit::TestCase

  def test_word_wrap
    assert_equal "abcde\n12345\nxyzwu\n", "abcde 12345 xyzwu".word_wrap(5)
    assert_equal "abcd\n1234\nxyzw\n", "abcd 1234 xyzw".word_wrap(4)
    assert_equal "abc\n123\n", "abc 123".word_wrap(4)
    assert_equal "abc \n123\n", "abc  123".word_wrap(4)
    assert_equal "abc \n123\n", "abc     123".word_wrap(4)
  end

  def test_word_wrap!
    w = "abcde 12345 xyzwu" ; w.word_wrap!(5)
    assert_equal("abcde\n12345\nxyzwu\n", w)
    w = "abcd 1234 xyzw" ; w.word_wrap!(4)
    assert_equal("abcd\n1234\nxyzw\n", w)
    w = "abc 123" ; w.word_wrap!(4)
    assert_equal "abc\n123\n", w
    w = "abc  123" ; w.word_wrap!(4)
    assert_equal("abc \n123\n", w)
    w = "abc     123" ; w.word_wrap!(4)
    assert_equal("abc \n123\n", w)
  end

# def test_word_wrap
#   assert_equal "abcde-\n12345-\nxyzwu\n", "abcde12345xyzwu".word_wrap(6,2)
#   assert_equal "abcd-\n1234-\nxyzw\n", "abcd1234xyzw".word_wrap(5,2)
#   assert_equal "abc \n123\n", "abc 123".word_wrap(4,2)
#   assert_equal "abc \n123\n", "abc  123".word_wrap(4,2)
#   assert_equal "abc \n123\n", "abc     123".word_wrap(4,2)
# end

end
