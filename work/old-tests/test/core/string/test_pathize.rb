require 'facets/string/pathize'
require 'test/unit'

class TC_String_Methodize < Test::Unit::TestCase

  def test_pathize_modulename
    a = "Foo::Base"
    r = "foo/base"
    assert_equal(r, a.pathize)
  end

  def test_pathize_pathname
    a = "foo/base"
    r = "foo/base"
    assert_equal(r, a.pathize)
  end

  def test_pathize_namespace
    a = "foo__base"
    r = "foo/base"
    assert_equal(r, a.pathize)
  end

end

