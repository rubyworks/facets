# Test for facets/hash/symbolize_keys.rb

require 'facets/hash/symbolize_keys.rb'
require 'test/unit'

class TestSymbolizeKeys < Test::Unit::TestCase

  def test_symbolize_keys
    foo = { 'a'=>1, 'b'=>2 }
    assert_equal( { :a=>1, :b=>2 }, foo.symbolize_keys )
    assert_equal( { "a" =>1, "b"=>2 }, foo )
  end

  def test_symbolize_keys!
    foo = { 'a'=>1, 'b'=>2 }
    assert_equal( { :a=>1, :b=>2 }, foo.symbolize_keys! )
    assert_equal( { :a=>1, :b=>2 }, foo  )
  end

end
