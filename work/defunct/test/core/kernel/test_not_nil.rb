require 'facets/kernel/not_nil.rb'
require 'test/unit'

class TestKernelNotNil < Test::Unit::TestCase

  def test_not_nil?
    assert_equal(true,  5.not_nil?)
    assert_equal(true,  :x.not_nil?)
    assert_equal(false, nil.not_nil?)
    assert_equal(true,  false.not_nil?)
  end

end
