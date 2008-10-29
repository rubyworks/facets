# Test facets/synchash.rb
#
# TODO: Need test!!!!!

require 'facets/synchash.rb'
require 'test/unit'

class TC_SyncHash < Test::Unit::TestCase

  def test_01
    assert_nothing_raised{ @h = SyncHash.new }
  end

end


