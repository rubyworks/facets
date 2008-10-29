require 'facets/instantise'
require 'test/unit'

# fixture

module MyModule
  extend Instantise
  def self.jumble( obj, arg )
    obj + arg
  end
end

class String
  include MyModule
end

# test

class TC_Instantise < Test::Unit::TestCase

  def test01
    assert_equal( 'TryMe', MyModule.jumble( "Try", "Me" ) )
  end

  def test02
    assert_equal( 'TryMe', "Try".jumble( "Me" ) )
  end

end

