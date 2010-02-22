require 'facets/enumerable/find_yield'
require 'test/unit'

class TestEnumerable < Test::Unit::TestCase
  
  def test_find_yields_a_value
    assert_equal true, [true].find_yield { |value| value }
  end

  def test_find_yield_detects_correct_value
    assert_equal 1, [1].find_yield { |value| value }
  end

  def test_find_yield_returns_value_of_block
    assert_equal 4, [1].find_yield { |v| v + 3 }
  end

  def test_find_yield_detects_first_truthy_value
    assert_equal 1, [false, false, 1].find_yield { |value| value }
  end

  def test_find_yield_returns_value_when_block_is_true
    assert_equal true, [false].find_yield { |value| true }
  end

  def test_find_yield_returns_early_when_block_is_true
    val1 = lambda { :something }
    val2 = lambda { raise "This shouldn't be called" }

    assert_equal :something, [val1, val2].find_yield { |obj| obj.call }
  end

  def test_find_yield_returns_nil_when_block_returns_false_for_all_elements
    assert_equal nil, [1,2,3,4].find_yield { |value| false }
  end

  def test_find_yield_returns_nil_when_no_elements_in_collection
    assert_equal nil, [].find_yield { |v| }
  end

  def test_find_yield_can_have_return_value_specified_when_block_isnt_true
    assert_equal :a_value, [1,2,3].find_yield(:a_value) { |value| false }
  end

  def test_find_yield_documentation_correct
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

    result = [obj1, obj2].find_yield { |obj| obj.foo if obj.foo? }
    assert_equal result, "a value"
  end
end
