require 'facets/proc/bind.rb'
require 'test/unit'

class TestProc < Test::Unit::TestCase

  # Not sure why this is thread critical?

  def test_memory_leak
    a = 2
    tproc = lambda { |x| x + a }
    99.times {
      tmethod = tproc.bind(self) #to_method
      assert_equal( 3, tmethod.call(1) )
    }
    meths = (
      Object.instance_methods +
      Object.public_instance_methods +
      Object.private_instance_methods +
      Object.protected_instance_methods
    )
    meths = meths.select{ |s| s.to_s =~ /^_bind_/ }
    #meths = Symbol.all_symbols.select { |s| s.to_s =~ /^_bind_/ }  # why?
    assert_equal( 0, meths.size )
  end

end
