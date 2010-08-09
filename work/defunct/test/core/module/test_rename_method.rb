require 'facets/module/rename_method'
require 'test/unit'

class Test_Module_Rename_Method < Test::Unit::TestCase

  def a; "A" ; end

  rename_method :b, :a

  def test_rename_method
    assert( ! respond_to?( :a ) )
    assert( respond_to?( :b ) )
  end

  # rename

  def c; "C" ; end

  rename :d, :c

  def test_rename
    assert( ! respond_to?( :c ) )
    assert( respond_to?( :d ) )
  end

end

