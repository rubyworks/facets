class String

  # Get a constant by a given string name.
  #
  #   "Class".to_const   #=> Class
  #
  # Note this method is not as verstile as it should be,
  # since it can not access contants relative to the current
  # execution context. But without a binding_of_caller that
  # does not seem possible.

  def to_const
    split('::').inject(Object){ |namespace,name| namespace.const_get(name) }
  end

end


__END__

require 'test/unit'

class TestStringConversion < Test::Unit::TestCase

  TestConst = 4

  def test_to_const
    assert_equal( 4, "TestStringConversion::TestConst".to_const )
  end

end
