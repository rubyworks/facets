require 'facets/equitable'

test_case Equatable do

  c = Class.new
  c.class_eval { 
    include Equitable(:a,:b)
    attr_accessor :a, :b
  }

  method :== do
    test "equatable with arguments" do
      c1,c2 = c.new,c.new
      c1.a = 10; c1.b = 20
      c2.a = 10; c2.b = 20
      assert(c1 == c2)

      c1.a = 10; c1.b = 10
      c2.a = 10; c2.b = 20
      refute(c1 == c2)

      c1.a = 10; c1.b = 20
      c2.a = 20; c2.b = 20
      refute(c1 == c2)
    end
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

