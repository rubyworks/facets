require 'facets/kernel/instance_class.rb'
require 'test/unit'

class TestKernelInstanceClass < Test::Unit::TestCase

  def test_instance_class
    o = Object.new
    assert_equal( (class << o; self; end), o.instance_class )
  end

end

