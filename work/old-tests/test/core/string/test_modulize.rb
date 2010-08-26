require 'facets/string/modulize'
require 'test/unit'

class TC_String_Modulize < Test::Unit::TestCase

  def test_modulize_snakecase
    a = "foo_bar"
    r = "FooBar"
    assert_equal(r, a.modulize)
  end

  def test_modulize_pathname
    a = "foo/bar"
    r = "Foo::Bar"
    assert_equal(r, a.modulize)
  end

  def test_modulize_on_methodized_string
    a = "foo__bar"
    r = "Foo::Bar"
    assert_equal(r, a.modulize)
  end

end

