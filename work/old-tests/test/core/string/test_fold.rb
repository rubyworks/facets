require 'facets/string/fold.rb'
require 'test/unit'

class Test_String_Fold < Test::Unit::TestCase

  def test_fold_1
    s = "This is\na test.\n\nIt clumps\nlines of text."
    o = "This is a test.\n\nIt clumps lines of text."
    assert_equal( o, s.fold )
  end

  def test_fold_2
    s = "This is\na test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps\nlines of text."
    o = "This is a test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps lines of text."
    assert_equal( o, s.fold(true) )
  end

end
