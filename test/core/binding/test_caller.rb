require 'facets/binding/caller.rb'
require 'test/unit'

class TestBindingCallStack < Test::Unit::TestCase

  def setup
    a = 1
    b = 2
    x = "hello"
    # the line number must be updated if it moves
    @bind = binding; @this_line_no = __LINE__
    @this_file_name = File.basename( __FILE__ ) # why does it equal basename only?
  end

  def test___LINE__
    assert_equal( @this_line_no, @bind.__LINE__ )
  end

  def test___FILE__
    assert_equal( @this_file_name, File.basename( @bind.__FILE__ ) )
  end

  def test___DIR__
    assert_equal( File.dirname( @bind.__FILE__ ), @bind.__DIR__ )
  end

  def test_callstack
    assert_instance_of( Array, @bind.callstack )
  end

  def test_caller
    # how to test?
    assert_nothing_raised{ @bind.caller }
  end

  def test_callee
    assert_equal( :setup, @bind.__callee__ )
  end

  def test_method
    assert_equal( 'setup', @bind.__method__ )
  end

end
