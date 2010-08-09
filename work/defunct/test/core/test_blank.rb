require 'facets/blank.rb'
require 'test/unit'

class TestStringBlank < Test::Unit::TestCase

  def test_blank?
    assert( ! "xyz".blank? )
    assert( "     ".blank? )
  end

end

