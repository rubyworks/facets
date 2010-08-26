require 'facets/kernel/assign_from.rb'
require 'test/unit'

class TestKernelAssignFrom < Test::Unit::TestCase

  C = Struct.new(:name, :address, :zip)

  def test_assign_from
    bob = C.new("Bob Sawyer", "123 Maple, Anytown NC", 12345)
    joe = C.new("Joe Pitare")

    joe.assign_from(bob, :address, :zip)

    assert_equal("Joe Pitare", joe.name)
    assert_equal("123 Maple, Anytown NC", joe.address)
    assert_equal(12345, joe.zip)
  end

end

