Covers 'facets/kernel/as'

Case Kernel do

  module SuperMethodHelpers
    class X ; def x ; 1 ; end ; end
    class Y < X ; def x ; 2 ; end ; end
    class Z < Y ; def x ; super_as(X) ; end ; end

    def test_super_as
      z = Z.new
      assert_equal( 1, z.x )
    end

    class X2 ; def x ; 1 ; end ; end
    class Y2 < X2 ; def x ; 2 ; end ; end
    class Z2 < Y2 ; def x ; 3 ; end ; end
  end

  Unit :super_method do
    x = SuperMethodHelpers::X2.new
    z = SuperMethodHelpers::Z2.new
    s0 = x.method( :x )
    s1 = z.super_method( SuperMethodHelpers::X2, :x )
    s1.call.assert == s0.call
  end

  module AsHelpers
    class A
      def x; "A.x"; end
      def y; "A.y"; end
    end
    class B < A
      def x; "B.x" end
      def y; "B.y" end
    end
    class C < B
      def x; "C.x"; end
      def y; as(B).x ; end
    end
  end

  Unit :as do
    c = AsHelpers::C.new
    c.y.assert == "B.x"
    c.x.assert == "C.x"
  end

  Unit :send_as do
    "A".send_as(Object, :class).assert == String
  end

end

