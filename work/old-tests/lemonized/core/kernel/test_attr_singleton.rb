require 'facets/kernel/attr_singleton.rb'
require 'test/unit'

class TestAttrSingleton < Test::Unit::TestCase

  class AttrSingletonMock
    def initialize
      attr_singleton_reader :foo #=> "FOO"
      attr_singleton_writer :bar #=> "BAR"
      attr_singleton_accessor :baz #=> "BAZ"
      @foo = "FOO"
      self.bar = "BAR"
      self.baz = "BAZ"
    end

    def get_bar
      @bar
    end
  end

  def test_attr_singleton_reader
    assert_nothing_raised { @t = AttrSingletonMock.new }
    assert_equal("FOO", @t.foo)
  end

  def test_attr_singleton_writer
    assert_nothing_raised { @t = AttrSingletonMock.new }
    assert_equal("BAR", @t.get_bar)
    @t.bar = "BAR2"
    assert_equal("BAR2", @t.get_bar)
  end

  def test_attr_singleton_accessor
    assert_nothing_raised { @t = AttrSingletonMock.new }
    assert_equal("BAZ", @t.baz)
    @t.baz = "BAZ2"
    assert_equal("BAZ2", @t.baz)
  end

end

