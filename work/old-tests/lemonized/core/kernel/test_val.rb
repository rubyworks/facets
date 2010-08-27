require 'facets/kernel/val.rb'
require 'test/unit'

class TestKernelVal < Test::Unit::TestCase

  def test_val_1
    f = nil
    t = 1
    assert( ! f.val? )
    assert( t.val? )
  end

  def test_val_2
    f = []
    t = [1]
    assert( ! f.val? )
    assert( t.val? )
  end

  def test_val_3
    f = ''
    t = '1'
    assert( ! f.val? )
    assert( t.val? )
  end

end
