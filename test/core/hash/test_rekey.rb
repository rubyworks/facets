require 'facets/hash/rekey'
require 'test/unit'

class Test_Hash_Rekey < Test::Unit::TestCase

  def test_rekey
    foo = { :a=>1, :b=>2 }
    foo = foo.rekey(:c, :a)
    assert_equal( 1, foo[:c] )
    assert_equal( 2, foo[:b] )
    assert_equal( nil, foo[:a] )
  end

  def test_rekey!
    foo = { :a=>1, :b=>2 }
    foo.rekey!(:c, :a)
    assert_equal( 1, foo[:c] )
    assert_equal( 2, foo[:b] )
    assert_equal( nil, foo[:a] )
  end

  def test_rekey_with_block
    foo = { :a=>1, :b=>2 }
    foo = foo.rekey{ |k| k.to_s }
    assert_equal( 1, foo['a'] )
    assert_equal( 2, foo['b'] )
    assert_equal( nil, foo[:a] )
    assert_equal( nil, foo[:b] )
  end

  def test_rekey_with_block!
    foo = { :a=>1, :b=>2 }
    foo.rekey!{ |k| k.to_s }
    assert_equal( 1, foo['a'] )
    assert_equal( 2, foo['b'] )
    assert_equal( nil, foo[:a] )
    assert_equal( nil, foo[:b] )
  end

  #

  def test_rekey_01
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.rekey{|k|k.to_s} )
    assert_equal( { :a =>1, :b=>2 }, foo  )
  end

  def test_rekey_02
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.rekey!{|k|k.to_s}  )
    assert_equal( { "a"=>1, "b"=>2 }, foo )
  end

  def test_rekey_03
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.rekey(:to_s) )
    assert_equal( { :a =>1, :b=>2 }, foo  )
  end

  def test_rekey_04
    foo = { :a=>1, :b=>2 }
    assert_equal( { "a"=>1, "b"=>2 }, foo.rekey!(:to_s) )
    assert_equal( { "a"=>1, "b"=>2 }, foo )
  end

  def test_rekey_05
    foo = { "a"=>1, "b"=>2 }
    assert_equal( { :a=>1, :b=>2 }, foo.rekey! )
    assert_equal( { :a=>1, :b=>2 }, foo )
  end

end

