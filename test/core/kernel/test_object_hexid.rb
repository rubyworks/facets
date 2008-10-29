require 'facets/kernel/object_hexid.rb'
require 'test/unit'

class TCKernel < Test::Unit::TestCase

  def test_object_hexid
    o = Object.new
    assert( o.inspect.index(o.object_hexid) )
  end

end

