class Symbol

  # Get a constant by a given symbol name.
  #
  #   :Class.to_const   #=> Class
  #
  # Note this method is not as verstile as it should be,
  # since it can not access contants relative to the current
  # execution context. But without a binding_of_caller that
  # does not seem possible.

  def to_const
    to_s.split('::').inject(Object){ |namespace,name| namespace.const_get(name) }
  end

end


__END__


class TestSymbolConversion < Test::Unit::TestCase

  TESTCONST = 1

  def test_to_const
    assert_equal( 1, :"TestSymbolConversion::TESTCONST".to_const )
  end

end

