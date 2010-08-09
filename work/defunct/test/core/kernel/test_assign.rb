require 'facets/kernel/assign.rb'
require 'test/unit'

class TestKernelAssign < Test::Unit::TestCase

  C = Struct.new(:name, :address, :zip)

  def test_assign_with_arguments
    bob = C.new

    bob.assign(:name, "Bob Sawyer")
    bob.assign(:address, "123 Maple, Anytown NC")
    bob.assign(:zip, 12345)

    assert_equal("Bob Sawyer", bob.name)
    assert_equal("123 Maple, Anytown NC", bob.address)
    assert_equal(12345, bob.zip)
  end

  def test_assign_with_hash
    bob = C.new

    x = { :name => "Bob Sawyer", :address => "123 Maple, Anytown NC", :zip => 12345 }

    bob.assign(x)

    assert_equal(x[:name], bob.name)
    assert_equal(x[:address], bob.address)
    assert_equal(x[:zip], bob.zip)
  end

  def test_assign_with_assoc_array
    bob = C.new

    x = [[:name, "Bob Sawyer"], [:address, "123 Maple, Anytown NC"], [:zip, 12345]]

    bob.assign(x)

    assert_equal("Bob Sawyer", bob.name)
    assert_equal("123 Maple, Anytown NC", bob.address)
    assert_equal(12345, bob.zip)
  end

  def test_assign_with_block
    bob = C.new

    x = lambda {|s| s.name = "Bob Sawyer"; s.address = "123 Maple, Anytown NC"; s.zip = 12345 }

    bob.assign(&x)

    assert_equal("Bob Sawyer", bob.name)
    assert_equal("123 Maple, Anytown NC", bob.address)
    assert_equal(12345, bob.zip)
  end

end

