require 'facets/equatable.rb'
require 'test/unit'

class TestModuleEquatable < Test::Unit::TestCase

  def test_equatable_with_arguments
    c = Class.new
    c.class_eval { 
      include Equatable(:a,:b)
      attr_accessor :a, :b
    }
    c1,c2 = c.new,c.new
    c1.a = 10; c1.b = 20
    c2.a = 10; c2.b = 20
    assert_equal( c1, c2 )
    c1.a = 10; c1.b = 10
    c2.a = 10; c2.b = 20
    assert_not_equal( c1, c2 )
    c1.a = 10; c1.b = 20
    c2.a = 20; c2.b = 20
    assert_not_equal( c1, c2 )
  end

=begin
  def test_equate_on_old
    c = Class.new
    c.class_eval { attr_accessor :a, :b ; equate_on :a,:b }
    c1,c2 = c.new,c.new
    c1.a = 10; c1.b = 20
    c2.a = 10; c2.b = 20
    assert_equal( c1, c2 )
    c1.a = 10; c1.b = 10
    c2.a = 10; c2.b = 20
    assert_not_equal( c1, c2 )
    c1.a = 10; c1.b = 20
    c2.a = 20; c2.b = 20
    assert_not_equal( c1, c2 )
  end
=end

end

