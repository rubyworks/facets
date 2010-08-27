require 'facets/string/methodize'
require 'test/unit'

class TC_String_Methodize < Test::Unit::TestCase

  def test_methodize_modulename
    a = "FooBase"
    r = "foo_base"
    assert_equal(r, a.methodize)
  end

  def test_methodize_pathname
    a = "foo/base"
    r = "foo__base"
    assert_equal(r, a.methodize)
  end

  def test_methodize_namespace
    a = "Foo::Base"
    r = "foo__base"
    assert_equal(r, a.methodize)
  end

end

