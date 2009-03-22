require 'facets/enumerable/map_detect'
require 'test/unit'

class TestEnumerable < Test::Unit::TestCase
  
  def test_map_detects_a_value
    assert_equal true, [true].map_detect { |value| value }
  end

  def test_map_detect_detects_correct_value
    assert_equal 1, [1].map_detect { |value| value }
  end

  def test_map_detect_returns_value_of_block
    assert_equal 4, [1].map_detect { |v| v + 3 }
  end

  def test_map_detect_detects_first_truthy_value
    assert_equal 1, [false, false, 1].map_detect { |value| value }
  end

  def test_map_detect_returns_value_when_block_is_true
    assert_equal true, [false].map_detect { |value| true }
  end

  def test_map_detect_returns_early_when_block_is_true
    val1 = lambda { :something }
    val2 = lambda { raise "This shouldn't be called" }

    assert_equal :something, [val1, val2].map_detect { |obj| obj.call }
  end

  def test_map_detect_returns_nil_when_block_returns_false_for_all_elements
    assert_equal nil, [1,2,3,4].map_detect { |value| false }
  end

  def test_map_detect_returns_nil_when_no_elements_in_collection
    assert_equal nil, [].map_detect { |v| }
  end

  def test_map_detect_can_have_return_value_specified_when_block_isnt_true
    assert_equal :a_value, [1,2,3].map_detect(:a_value) { |value| false }
  end

  def test_map_detect_documentation_correct
    obj1, obj2 = Object.new, Object.new

    class << obj1
      def foo?
        false
      end

      def foo
        raise
      end
    end

    class << obj2
      def foo?
        true
      end

      def foo
        "a value"
      end
    end

    assert_equal false, obj1.foo?
    assert_equal true, obj2.foo?
    assert_equal "a value", obj2.foo

    result = [obj1, obj2].map_detect { |obj| obj.foo if obj.foo? }
    assert_equal result, "a value"
  end
end
