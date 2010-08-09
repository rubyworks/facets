require 'facets/kernel/callstack.rb'
require 'test/unit'

class TestCallStack < Test::Unit::TestCase

  def test_callstack
    assert_nothing_raised{ callstack }
  end

end
