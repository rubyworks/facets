require 'facets/dir.rb'
require 'test/unit'

class TC_Dir_Parent < Test::Unit::TestCase

  def test_parent
    assert( Dir.parent?( "a/b/c", "a/b/c/d" ) )
  end

end

