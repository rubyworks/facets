# Test facets/hash/stringify_keys.rb

require 'facets/hash/stringify_keys.rb'
require 'test/unit'

class TestHashStringifyKeys < Test::Unit::TestCase

  def test_stringify_keys
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.stringify_keys )
    assert_equal( { :a =>1, :b=>2 }, foo  )
  end

  def test_stringify_keys!
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.stringify_keys!  )
    assert_equal( { "a"=>1, "b"=>2 }, foo )
  end

end

