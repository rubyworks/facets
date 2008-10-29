# Test facets/syncarray.rb
#
# TODO: Need test!!!!!!!!!

require 'facets/syncarray.rb'
require 'test/unit'

class TC_SyncArray < Test::Unit::TestCase

  def test_01
    assert_nothing_raised{ @s = SyncArray.new }
  end

end

