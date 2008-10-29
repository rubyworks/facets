require 'facets/cloneable'
require 'test/unit'

class Foo
  include Cloneable
  def initialize
    @bar=[]
  end
  def bar_id
    @bar.object_id
  end
end

class TestCloneable < Test::Unit::TestCase
  def test_dup
    a=Foo.new
    b=a.dup
    assert_not_equal a.bar_id,b.bar_id

    a.taint
    b=a.dup
    assert b.tainted?, "b should be tainted"

    a.freeze
    b=a.dup
    assert !b.frozen?, "b should not be frozen"
  end
  def test_clone
    a=Foo.new
    b=a.clone
    assert_not_equal a.bar_id,b.bar_id

    a.taint
    b=a.dup
    assert b.tainted?, "b should be tainted"

    a.freeze
    b=a.clone
    assert b.frozen?, "b should be frozen"
  end
end
