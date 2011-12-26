testcase Math do

#  def test_constants
#    assert_equal(Math::E,  Math::E)
#    assert_equal_float(0.577_215_664_901_532_861, Math::C, 1.0e-18)
#  end

  def test_trigonometric_functions

    # Check identity of Math.acsc(x) and Math.asin(1/x)
    assert_equal_float(Math.asin(-1.0), Math.acsc(-1.0), 1.0e-6)
    assert_equal_float(Math.asin(-0.5), Math.acsc(-2.0), 1.0e-6)
    assert_equal_float(Math.asin( 0.5), Math.acsc( 2.0), 1.0e-6)
    assert_equal_float(Math.asin( 1.0), Math.acsc( 1.0), 1.0e-6)

    # Check identity of Math.acos and Math.acos
    assert_equal(Math.acos(-1.0), Math.acos(-1.0))
    assert_equal(Math.acos( 1.0), Math.acos( 1.0))

    # Check behavior of acot
    assert_equal_float(0.5 * Math::PI - Math.atan(-1.0), Math.acot(-1.0), 1.0e-6)
    assert_equal_float(0.5 * Math::PI - Math.atan( 1.0), Math.acot( 1.0), 1.0e-6)

    # Check identity of Math.asec(x) and Math.acos(1/x)
    assert_equal_float(Math.acos(-1.0), Math.asec(-1.0), 1.0e-6)
    assert_equal_float(Math.acos(-0.5), Math.asec(-2.0), 1.0e-6)
    assert_equal_float(Math.acos( 0.5), Math.asec( 2.0), 1.0e-6)
    assert_equal_float(Math.acos( 1.0), Math.asec( 1.0), 1.0e-6)

    # Check identity of Math.asin and Math.asin
    assert_equal(Math.asin(-1.0), Math.asin(-1.0))
    assert_equal(Math.asin( 1.0), Math.asin( 1.0))

    # Check identity of Math.atan and Math.atan
    assert_equal(Math.atan(-1.0), Math.atan(-1.0))
    assert_equal(Math.atan( 1.0), Math.atan( 1.0))

    # Check identity of Math.atan2 and Math.atan2
    assert_equal(Math.atan2(-3.1, 3.1), Math.atan2(-3.1, 3.1))
    assert_equal(Math.atan2( 3.1, 3.1), Math.atan2( 3.1, 3.1))

    # Check identity of Math.cos and Math.cos
    assert_equal(Math.cos(-1.0), Math.cos(-1.0))
    assert_equal(Math.cos( 1.0), Math.cos( 1.0))

    # Check identity of Math.asin and 1.0 / Math.sin
    assert_equal(1.0 / Math.sin(-1.0), Math.csc(-1.0))
    assert_equal(1.0 / Math.sin( 1.0), Math.csc( 1.0))

    # Check identity of Math.cot and 1.0 / Math.tan
    assert_equal_float(1.0 / Math.tan(1.0), Math.cot(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.tan(2.0), Math.cot(2.0), 1.0e-6)

    # Check identity of Math.sec and 1.0 / Math.cos
    assert_equal_float(1.0 / Math.cos(1.0), Math.sec(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.cos(2.0), Math.sec(2.0), 1.0e-6)

    # Check identity of Math.sin and Math.sin
    assert_equal(Math.sin(-1.0), Math.sin(-1.0))
    assert_equal(Math.sin( 1.0), Math.sin( 1.0))

    # Check identity of Math.tan and Math.tan
    assert_equal(Math.tan(-1.0), Math.tan(-1.0))
    assert_equal(Math.tan( 1.0), Math.tan( 1.0))

  end

  def test_hyperbolic_functions

    # Check behavior of acsch
    assert_equal_float(-0.881_373_6, Math.acsch(-1.0), 1.0e-6)
    assert_equal_float(-1.443_635_5, Math.acsch(-0.5), 1.0e-6)
    assert_equal_float( 1.443_635_5, Math.acsch( 0.5), 1.0e-6)
    assert_equal_float( 0.881_373_6, Math.acsch( 1.0), 1.0e-6)

    # Check identity of Math.acosh and Math.acosh
    assert_equal(Math.acosh(1.0), Math.acosh(1.0))
    assert_equal(Math.acosh(2.0), Math.acosh(2.0))

    # Check behavior of acoth
    assert_equal_float(0.5 * Math.log(5.0), Math.acoth(1.5), 1.0e-6)
    assert_equal_float(0.5 * Math.log(1.5), Math.acoth(5.0), 1.0e-6)

    # Check behavior of asech
    assert_equal_float(2.993_222_8, Math.asech(0.1), 1.0e-6)
    assert_equal_float(1.098_612_2, Math.asech(0.6), 1.0e-6)
    assert_equal_float(0.0,         Math.asech(1.0), 1.0e-6)

    # Check identity of Math.asinh and Math.asinh
    assert_equal(Math.asinh(-1.0), Math.asinh(-1.0))
    assert_equal(Math.asinh( 1.0), Math.asinh( 1.0))

    # Check identity of Math.atanh and Math.atanh
    assert_equal(Math.atanh(-0.5), Math.atanh(-0.5))
    assert_equal(Math.atanh( 0.5), Math.atanh( 0.5))

    # Check identity of Math.acsch and 1.0 / Math.sinh
    assert_equal(1.0 / Math.sinh(-1.0), Math.csch(-1.0))
    assert_equal(1.0 / Math.sinh( 1.0), Math.csch( 1.0))

    # Check identity of Extmat.cosh and Math.cosh
    assert_equal(Math.cosh(-1.0), Math.cosh(-1.0))
    assert_equal(Math.cosh( 1.0), Math.cosh( 1.0))

    # Check identity of Extmat.coth and 1.0 / Math.tanh
    assert_equal_float(1.0 / Math.tanh(1.0), Math.coth(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.tanh(2.0), Math.coth(2.0), 1.0e-6)

    # Check identity of Extmat.sech and 1.0 / Math.cosh
    assert_equal_float(1.0 / Math.cosh(1.0), Math.sech(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.cosh(2.0), Math.sech(2.0), 1.0e-6)

    # Check identity of Extmat.sinh and Math.sinh
    assert_equal(Math.sinh(-1.0), Math.sinh(-1.0))
    assert_equal(Math.sinh( 1.0), Math.sinh( 1.0))

    # Check identity of Extmat.tanh and Math.tanh
    assert_equal(Math.tanh(-1.0), Math.tanh(-1.0))
    assert_equal(Math.tanh( 1.0), Math.tanh( 1.0))

  end

  def test_explog_functions

    # Check behavior of exp
    assert_equal_float(               1.0, Math.exp(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(Math::E), Math.exp(0.5), 1.0e-6)
    assert_equal_float(           Math::E, Math.exp(1.0), 1.0e-6)

    # Check behavior of exp10
    assert_equal_float(            1.0, Math.exp10(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(10.0), Math.exp10(0.5), 1.0e-6)
    assert_equal_float(           10.0, Math.exp10(1.0), 1.0e-6)

    # Check behavior of exp2
    assert_equal_float(           1.0, Math.exp2(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(2.0), Math.exp2(0.5), 1.0e-6)
    assert_equal_float(           2.0, Math.exp2(1.0), 1.0e-6)

    # Check behavior of frexp
    assert_equal([-0.996_093_75, 8], Math.frexp(-255.0))
    assert_equal([-0.5,          1], Math.frexp(  -1.0))
    assert_equal([ 0.0,          0], Math.frexp(   0.0))
    assert_equal([ 0.5,          1], Math.frexp(   1.0))
    assert_equal([ 0.996_093_75, 8], Math.frexp( 255.0))

    # Check behavior of ldexp
    assert_equal_float(1.0, Math.ldexp(0.25, 2), 1.0e-6)
    assert_equal_float(1.0, Math.ldexp(0.5,  1), 1.0e-6)
    assert_equal_float(1.0, Math.ldexp(2,   -1), 1.0e-6)
    assert_equal_float(1.0, Math.ldexp(4,   -2), 1.0e-6)

    # Check identity of Extmat.log and Math.log
    assert_equal(Math.log(2.0), Math.log(2.0))
    assert_equal(Math.log(3.0), Math.log(3.0))

    # Check identity of Extmat.log10 and Math.log10
    assert_equal(Math.log10(2.0), Math.log10(2.0))
    assert_equal(Math.log10(3.0), Math.log10(3.0))

    # Check behavior of log2
    assert_equal_float(0.5, Math.log2(Math.sqrt(2.0)), 1.0e-6)
    assert_equal_float(1.0,            Math.log2(2.0), 1.0e-6)
    assert_equal_float(2.0,            Math.log2(4.0), 1.0e-6)

  end

  def test_pwr_functions

    # Check behavior of pow
    assert_equal_float(64.0,   Math.pow( 4.0,        3.0), 1.0e-6)
    assert_equal_float( 0.729, Math.pow( 0.9,        3.0), 1.0e-6)
    assert_equal_float( 0.25,  Math.pow(64.0, -1.0 / 3.0), 1.0e-6)
    assert_equal_float( 2.0,   Math.pow( 0.25,      -0.5), 1.0e-6)

    # Check behavior of root
    assert_equal_float( 4.0,  Math.root(64.0,          3.0), 1.0e-6)
    assert_equal_float( 0.9,  Math.root( 0.729,        3.0), 1.0e-6)
    assert_equal_float(64.0,  Math.root( 0.25,  -1.0 / 3.0), 1.0e-6)
    assert_equal_float( 0.25, Math.root( 2.0,         -0.5), 1.0e-6)

    # Check behavior of sqr
    assert_equal_float(0.81, Math.sqr(-0.9), 1.0e-6)
    assert_equal_float(0.49, Math.sqr(-0.7), 1.0e-6)
    assert_equal_float(0.49, Math.sqr(-0.7), 1.0e-6)
    assert_equal_float(0.81, Math.sqr( 0.9), 1.0e-6)

    # Check behavior of sqrt
    assert_equal_float(0.7, Math.sqrt(0.49), 1.0e-6)
    assert_equal_float(0.9, Math.sqrt(0.81), 1.0e-6)

  end

  def test_rounding_functions

    # Check behavior of ceil
    assert_equal( 2, Math.ceil( 1.999_99))
    assert_equal( 2, Math.ceil( 1.5))
    assert_equal( 2, Math.ceil( 1.000_01))
    assert_equal( 1, Math.ceil( 0.999_99))
    assert_equal( 1, Math.ceil( 0.5))
    assert_equal( 1, Math.ceil( 0.000_01))
    assert_equal( 0, Math.ceil(-0.000_01))
    assert_equal( 0, Math.ceil(-0.5))
    assert_equal( 0, Math.ceil(-0.999_99))
    assert_equal(-1, Math.ceil(-1.000_01))
    assert_equal(-1, Math.ceil(-1.5))
    assert_equal(-1, Math.ceil(-1.999_99))

    # Check behavior of floor
    assert_equal( 1, Math.floor( 1.999_99))
    assert_equal( 1, Math.floor( 1.5))
    assert_equal( 1, Math.floor( 1.000_01))
    assert_equal( 0, Math.floor( 0.999_99))
    assert_equal( 0, Math.floor( 0.5))
    assert_equal( 0, Math.floor( 0.000_01))
    assert_equal(-1, Math.floor(-0.000_01))
    assert_equal(-1, Math.floor(-0.5))
    assert_equal(-1, Math.floor(-0.999_99))
    assert_equal(-2, Math.floor(-1.000_01))
    assert_equal(-2, Math.floor(-1.5))
    assert_equal(-2, Math.floor(-1.999_99))

    # Check behavior of round
    assert_equal( 2, Math.round( 1.5))
    assert_equal( 1, Math.round( 1.4))
    assert_equal( 1, Math.round( 0.5))
    assert_equal( 0, Math.round( 0.4))
    assert_equal( 0, Math.round(-0.4))
    assert_equal(-1, Math.round(-0.5))
    assert_equal(-1, Math.round(-1.4))
    assert_equal(-2, Math.round(-1.5))

  end

  def test_tensors

    1.upto(3) { |i|
      1.upto(3) { |j|
        assert_equal(i == j ? 1 : 0, Math.delta(i, j))
      }
    }

    1.upto(3) { |i|
      1.upto(3) { |j|
        1.upto(3) { |k|
          case [i,j,k]
            when [1,2,3] then assert_equal( 1, Math.epsilon(i, j, k))
            when [1,3,2] then assert_equal(-1, Math.epsilon(i, j, k))
            when [2,1,3] then assert_equal(-1, Math.epsilon(i, j, k))
            when [2,3,1] then assert_equal( 1, Math.epsilon(i, j, k))
            when [3,1,2] then assert_equal( 1, Math.epsilon(i, j, k))
            when [3,2,1] then assert_equal(-1, Math.epsilon(i, j, k))
            else              assert_equal( 0, Math.epsilon(i, j, k))
          end
        }
      }
    }

  end

  def test_solvers

    ###############################################################################################################################
    # Check linsolve
    ###############################################################################################################################

    assert_nil(Math.linsolve(0.0, 1.0, 1.0))
    assert_nil(Math.linsolve(0.0, 2.0))

    assert_equal_float( 1.0, Math.linsolve(3.0,  6.0, 9.0), 1.0e-6)
    assert_equal_float(-3.0, Math.linsolve(9.0, 27.0, 0.0), 1.0e-6)
    assert_equal_float(-3.0, Math.linsolve(9.0, 27.0),      1.0e-6)

    assert_equal(Math.linsolve(7.0, 21.0, 0.0), Math.linsolve(7.0, 21.0))

    ###############################################################################################################################
    # Check sqsolve
    ###############################################################################################################################

    assert_equal(nil, Math.sqsolve(0.0, 0.0, 1.0, 1.0))
    assert_equal(nil, Math.sqsolve(0.0, 0.0, 2.0))
    assert_equal(nil, Math.sqsolve(7.0, 0.0, 5.0, 3.0))

    assert_equal(Array, Math.sqsolve(0.0,  3.0,   6.0,  9.0).class)
    assert_equal(Array, Math.sqsolve(0.0,  9.0,  27.0,  0.0).class)
    assert_equal(Array, Math.sqsolve(0.0,  9.0,  27.0      ).class)
    assert_equal(Array, Math.sqsolve(7.0,  0.0,   3.0,  3.0).class)
    assert_equal(Array, Math.sqsolve(2.0, -3.0,   3.0,  3.0).class)
    assert_equal(Array, Math.sqsolve(4.0,  0.0,   1.0, 15.0).class)
    assert_equal(Array, Math.sqsolve(3.0,  6.0,   1.0, -2.0).class)
    assert_equal(Array, Math.sqsolve(9.0, 18.0,   6.0,  6.0).class)
    assert_equal(Array, Math.sqsolve(3.0,  6.0, -21.0,  0.0).class)

    assert_equal(1, Math.sqsolve(0.0,  3.0,   6.0,  9.0).length)
    assert_equal(1, Math.sqsolve(0.0,  9.0,  27.0,  0.0).length)
    assert_equal(1, Math.sqsolve(0.0,  9.0,  27.0      ).length)
    assert_equal(2, Math.sqsolve(7.0,  0.0,   3.0,  3.0).length)
    assert_equal(2, Math.sqsolve(2.0, -3.0,   3.0,  3.0).length)
    assert_equal(2, Math.sqsolve(4.0,  0.0,   1.0, 15.0).length)
    assert_equal(2, Math.sqsolve(3.0,  6.0,   1.0, -2.0).length)
    assert_equal(2, Math.sqsolve(9.0, 18.0,   6.0,  6.0).length)
    assert_equal(2, Math.sqsolve(9.0,  6.0, -21.0,  0.0).length)

    assert_equal(Math.sqsolve(0.0, 7.0, 21.0, 0.0), Math.sqsolve(0.0, 7.0, 21.0))
    assert_equal(Math.sqsolve(2.0, 3.0,  4.0, 4.0), Math.sqsolve(2.0, 3.0,  0.0))

    assert_equal_float( 1.0,                Math.sqsolve(0.0,  3.0,   6.0,  9.0)[0], 1.0e-6)
    assert_equal_float(-3.0,                Math.sqsolve(0.0,  9.0,  27.0,  0.0)[0], 1.0e-6)
    assert_equal_float(-3.0,                Math.sqsolve(0.0,  9.0,  27.0      )[0], 1.0e-6)
    assert_equal_float( 0.0,                Math.sqsolve(7.0,  0.0,   3.0,  3.0)[0], 1.0e-6)
    assert_equal_float( 0.0,                Math.sqsolve(2.0, -3.0,   3.0,  3.0)[0], 1.0e-6)
    assert_equal_float(-2.0,                Math.sqsolve(4.0,  0.0,  -1.0, 15.0)[0], 1.0e-6)
    assert_equal_float(-1.0,                Math.sqsolve(3.0,  6.0,   1.0, -2.0)[0], 1.0e-6)
    assert_equal_float(-2.0,                Math.sqsolve(9.0, 18.0,   6.0,  6.0)[0], 1.0e-6)
    assert_equal_float(-1.0 - Math.sqrt(8), Math.sqsolve(3.0,  6.0, -21.0,  0.0)[0], 1.0e-6)

    assert_equal_float(0.0,                 Math.sqsolve(7.0,  0.0,   3.0,  3.0)[1], 1.0e-6)
    assert_equal_float(1.5,                 Math.sqsolve(2.0, -3.0,   3.0,  3.0)[1], 1.0e-6)
    assert_equal_float(2.0,                 Math.sqsolve(4.0,  0.0,  -1.0, 15.0)[1], 1.0e-6)
    assert_equal_float(-1.0,                Math.sqsolve(3.0,  6.0,   1.0, -2.0)[1], 1.0e-6)
    assert_equal_float( 0.0,                Math.sqsolve(9.0, 18.0,   6.0,  6.0)[1], 1.0e-6)
    assert_equal_float(-1.0 + Math.sqrt(8), Math.sqsolve(3.0,  6.0, -21.0,  0.0)[1], 1.0e-6)

  end

  def test_conversions

    assert_equal_float( 90.0,               Math.rad2deg(0.5 * Math::PI), 1.0e-6)
    assert_equal_float(180.0 / Math::PI, Math.rad2deg(1.0),               1.0e-6)

    assert_equal_float(100.0,               Math.rad2gon(0.5 * Math::PI), 1.0e-6)
    assert_equal_float(200.0 / Math::PI, Math.rad2gon(1.0),               1.0e-6)

    assert_equal_float( 0.5 * Math::PI,       Math.deg2rad( 90.0), 1.0e-6)
    assert_equal_float(10.0 * Math::PI / 9.0, Math.deg2rad(200.0), 1.0e-6)

    assert_equal_float( 100.0,       Math.deg2gon( 90.0), 1.0e-6)
    assert_equal_float(2000.0 / 9.0, Math.deg2gon(200.0), 1.0e-6)

    assert_equal_float(0.5  * Math::PI, Math.gon2rad(100.0), 1.0e-6)
    assert_equal_float(0.21 * Math::PI, Math.gon2rad( 42.0), 1.0e-6)

    assert_equal_float(90.0, Math.gon2deg(100.0), 1.0e-6)
    assert_equal_float(37.8, Math.gon2deg( 42.0), 1.0e-6)

  end

  def test_misc_functions

    # Check behavior of beta
    assert_equal_float( 1.0,        Math.beta(1.0, 1.0), 1.0e-6)
    assert_equal_float( 0.5,        Math.beta(1.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 /  3.0, Math.beta(1.0, 3.0), 1.0e-6)
    assert_equal_float( 0.5,        Math.beta(2.0, 1.0), 1.0e-6)
    assert_equal_float( 1.0 /  6.0, Math.beta(2.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 / 12.0, Math.beta(2.0, 3.0), 1.0e-6)
    assert_equal_float( 1.0 /  3.0, Math.beta(3.0, 1.0), 1.0e-6)
    assert_equal_float( 1.0 / 12.0, Math.beta(3.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 / 30.0, Math.beta(3.0, 3.0), 1.0e-6)

    # Check behavior of erf and erfc
    assert_equal_float(0.0, Math.erf(0.0),  1.0e-6)
    assert_equal_float(1.0, Math.erfc(0.0), 1.0e-6)

    # Check behavior of factorial
    fac = 1
    1.upto(100) {|i|
      fac *= i
      assert_equal(fac, Math.factorial(i))
    }

    # Check behavior of tgamma (assert data that can be found in Bronstein-Semendjajew).
    assert_equal_float(1.000_00, Math.tgamma(1.00), 1.0e-5)
    assert_equal_float(0.947_40, Math.tgamma(1.11), 1.0e-5)
    assert_equal_float(0.913_11, Math.tgamma(1.22), 1.0e-5)
    assert_equal_float(0.893_38, Math.tgamma(1.33), 1.0e-5)
    assert_equal_float(0.885_81, Math.tgamma(1.44), 1.0e-5)
    assert_equal_float(0.888_87, Math.tgamma(1.55), 1.0e-5)
    assert_equal_float(0.901_67, Math.tgamma(1.66), 1.0e-5)
    assert_equal_float(0.923_76, Math.tgamma(1.77), 1.0e-5)
    assert_equal_float(0.955_07, Math.tgamma(1.88), 1.0e-5)
    assert_equal_float(0.995_81, Math.tgamma(1.99), 1.0e-5)

    # Check behavior of gcd
    assert_equal(                   4,    Math.gcd(                4_732, 4_700))
    assert_equal(                   1,    Math.gcd(                3_651, 5_023))
    assert_equal(Math.factorial(47),   Math.gcd(Math.factorial(90), Math.factorial(47)))
    assert_equal(              5_565_651, Math.gcd(          612_221_610, 67_461_255_771))

    # Check behavior of hypoth
    assert_equal_float(Math.sqrt( 5.0), Math.hypot(1.0, 2.0), 1.0e-6)
    assert_equal_float(Math.sqrt(13.0), Math.hypot(2.0, 3.0), 1.0e-6)
    assert_equal_float(            5.0, Math.hypot(3.0, 4.0), 1.0e-6)

    # Check behavior of lcm
    assert_equal(17_017, Math.lcm( 77, 221))
    assert_equal( 2_431, Math.lcm(143, 187))
    assert_equal( 1_547, Math.lcm( 91, 119))

    # Check behavior of lgamma
    assert_equal_float(               0.0, Math.lgamma(2.0), 1.0e-6)
    assert_equal_float(Math.log(  2.0), Math.lgamma(3.0), 1.0e-6)
    assert_equal_float(Math.log(  6.0), Math.lgamma(4.0), 1.0e-6)
    assert_equal_float(Math.log( 24.0), Math.lgamma(5.0), 1.0e-6)
    assert_equal_float(Math.log(120.0), Math.lgamma(6.0), 1.0e-6)
    assert_equal_float(Math.log(720.0), Math.lgamma(7.0), 1.0e-6)

    # Check behavior of sinc
    assert_equal_float(                1.0, Math.sinc( 0.0), 0.0)
    assert_equal_float(      Math.sin(1.0), Math.sinc( 1.0), 0.0)
    assert_equal_float(      Math.sin(1.0), Math.sinc(-1.0), 0.0)
    assert_equal_float(0.5 * Math.sin(2.0), Math.sinc( 2.0), 0.0)
    assert_equal_float(0.5 * Math.sin(2.0), Math.sinc(-2.0), 0.0)

  end

  def test_sign_consistency

    # Check complementarity of abs and sign
    assert_equal_float(-2.0, Math.abs(-2.0) * Math.sign(-2.0), 1e-6)
    assert_equal_float( 0.0, Math.abs( 0.0) * Math.sign( 0.0), 1e-6)
    assert_equal_float( 3.0, Math.abs( 3.0) * Math.sign( 3.0), 1e-6)

  end

  def test_trigonometric_consistency

    # Check complementarity of acos and cos
    assert_equal_float( 0.5, Math.acos(Math.cos(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.cos(Math.acos(-0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.acos(Math.cos( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.cos(Math.acos( 0.5)), 1.0e-6)

    # Check complementarity of acot and cot
    assert_equal_float(1.0, Math.acot(Math.cot(1.0)), 1.0e-6)
    assert_equal_float(1.0, Math.cot(Math.acot(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.acot(Math.cot(2.0)), 1.0e-6)
    assert_equal_float(2.0, Math.cot(Math.acot(2.0)), 1.0e-6)

    # Check complementarity of acsc and csc
    assert_equal_float(-0.5, Math.acsc(Math.csc(-0.5)), 1.0e-6)
    assert_equal_float(-2.0, Math.csc(Math.acsc(-2.0)), 1.0e-6)
    assert_equal_float( 0.5, Math.acsc(Math.csc( 0.5)), 1.0e-6)
    assert_equal_float( 2.0, Math.csc(Math.acsc( 2.0)), 1.0e-6)

    # Check complementarity of asec and sec
    assert_equal_float( 0.5, Math.asec(Math.sec(-0.5)), 1.0e-6)
    assert_equal_float(-2.0, Math.sec(Math.asec(-2.0)), 1.0e-6)
    assert_equal_float( 0.5, Math.asec(Math.sec( 0.5)), 1.0e-6)
    assert_equal_float( 2.0, Math.sec(Math.asec( 2.0)), 1.0e-6)

    # Check complementarity of asin and sin
    assert_equal_float( 0.5, Math.asin(Math.sin( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.sin(Math.asin( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.asin(Math.sin(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.sin(Math.asin(-0.5)), 1.0e-6)

    # Check consistency of atan2 and acot
    assert_equal_float(Math.atan2(1.0, 1.0), Math.acot(1.0), 1.0e-6)
    assert_equal_float(Math.atan2(1.0, 2.0), Math.acot(2.0), 1.0e-6)

    # Check consistency of atan2 and atan
    assert_equal_float(Math.atan2(-3.1, 3.1), Math.atan(-1.0), 1.0e-6)
    assert_equal_float(Math.atan2( 3.1, 3.1), Math.atan( 1.0), 1.0e-6)

    # Check complementarity of atan and tan
    assert_equal_float( 0.5, Math.atan(Math.tan( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.tan(Math.atan( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.atan(Math.tan(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.tan(Math.atan(-0.5)), 1.0e-6)

    # Check complementarity of cos and sec
    assert_equal_float(1.0, Math.sec(-2.0) * Math.cos(-2.0), 1.0e-6)
    assert_equal_float(1.0, Math.sec(-1.0) * Math.cos(-1.0), 1.0e-6)
    assert_equal_float(1.0, Math.sec( 1.0) * Math.cos( 1.0), 1.0e-6)
    assert_equal_float(1.0, Math.sec( 2.0) * Math.cos( 2.0), 1.0e-6)

    # Check complementarity of csc and sin
    assert_equal_float(1.0, Math.csc(-2.0) * Math.sin(-2.0), 1.0e-6)
    assert_equal_float(1.0, Math.csc(-1.0) * Math.sin(-1.0), 1.0e-6)
    assert_equal_float(1.0, Math.csc( 1.0) * Math.sin( 1.0), 1.0e-6)
    assert_equal_float(1.0, Math.csc( 2.0) * Math.sin( 2.0), 1.0e-6)

  end

  def test_hyperbolic_consistency

    # Check complimentarity of acsch and csch
    assert_equal_float(-1.0, Math.csch(Math.acsch(-1.0)), 1.0e-6)
    assert_equal_float(-1.0, Math.acsch(Math.csch(-1.0)), 1.0e-6)
    assert_equal_float(-0.5, Math.csch(Math.acsch(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.acsch(Math.csch(-0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.csch(Math.acsch( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.acsch(Math.csch( 0.5)), 1.0e-6)
    assert_equal_float( 1.0, Math.csch(Math.acsch( 1.0)), 1.0e-6)
    assert_equal_float( 1.0, Math.acsch(Math.csch( 1.0)), 1.0e-6)

    # Check complementarity of acosh and cosh
    assert_equal_float(1.5, Math.acosh(Math.cosh( 1.5)), 1.0e-6)
    assert_equal_float(1.5, Math.cosh(Math.acosh( 1.5)), 1.0e-6)
    assert_equal_float(1.5, Math.acosh(Math.cosh(-1.5)), 1.0e-6)

    # Check complementarity of acoth and coth
    assert_equal_float( 1.5, Math.acoth(Math.coth( 1.5)), 1.0e-6)
    assert_equal_float( 1.5, Math.coth(Math.acoth( 1.5)), 1.0e-6)
    assert_equal_float(-1.5, Math.acoth(Math.coth(-1.5)), 1.0e-6)
    assert_equal_float(-1.5, Math.coth(Math.acoth(-1.5)), 1.0e-6)

    # Check complimentarity of asech and sech
    assert_equal_float( 0.1, Math.sech(Math.asech(0.1)), 1.0e-6)
    assert_equal_float( 0.1, Math.asech(Math.sech(0.1)), 1.0e-6)
    assert_equal_float( 0.6, Math.sech(Math.asech(0.6)), 1.0e-6)
    assert_equal_float( 0.6, Math.asech(Math.sech(0.6)), 1.0e-6)
    assert_equal_float( 1.0, Math.sech(Math.asech(1.0)), 1.0e-6)
    assert_equal_float( 1.0, Math.asech(Math.sech(1.0)), 1.0e-6)

    # Check complementarity of asinh and sinh
    assert_equal_float( 1.5, Math.asinh(Math.sinh( 1.5)), 1.0e-6)
    assert_equal_float( 1.5, Math.sinh(Math.asinh( 1.5)), 1.0e-6)
    assert_equal_float(-1.5, Math.asinh(Math.sinh(-1.5)), 1.0e-6)
    assert_equal_float(-1.5, Math.sinh(Math.asinh(-1.5)), 1.0e-6)

    # Check complementarity of atanh and tanh
    assert_equal_float( 0.5, Math.atanh(Math.tanh( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Math.tanh(Math.atanh( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.atanh(Math.tanh(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Math.tanh(Math.atanh(-0.5)), 1.0e-6)

    # Check complementarity of csch and sinh
    assert_equal_float(1.0, Math.csch(-2.0) * Math.sinh(-2.0), 1.0e-6)
    assert_equal_float(1.0, Math.csch(-1.0) * Math.sinh(-1.0), 1.0e-6)
    assert_equal_float(1.0, Math.csch( 1.0) * Math.sinh( 1.0), 1.0e-6)
    assert_equal_float(1.0, Math.csch( 2.0) * Math.sinh( 2.0), 1.0e-6)

    # Check complementarity of cosh and sech
    assert_equal_float(1.0, Math.sech(-2.0) * Math.cosh(-2.0), 1.0e-6)
    assert_equal_float(1.0, Math.sech(-1.0) * Math.cosh(-1.0), 1.0e-6)
    assert_equal_float(1.0, Math.sech( 1.0) * Math.cosh( 1.0), 1.0e-6)
    assert_equal_float(1.0, Math.sech( 2.0) * Math.cosh( 2.0), 1.0e-6)

  end

  def test_explog_consistency

    # Check complementarity of exp and log
    assert_equal_float(0.5, Math.log(Math.exp(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.log(Math.exp(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.log(Math.exp(2.0)), 1.0e-6)
    assert_equal_float(0.5, Math.exp(Math.log(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.exp(Math.log(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.exp(Math.log(2.0)), 1.0e-6)

    # Check complementarity of exp10 and log10
    assert_equal_float(0.5, Math.log10(Math.exp10(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.log10(Math.exp10(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.log10(Math.exp10(2.0)), 1.0e-6)
    assert_equal_float(0.5, Math.exp10(Math.log10(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.exp10(Math.log10(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.exp10(Math.log10(2.0)), 1.0e-6)

    # Check complementarity of exp2 and log2
    assert_equal_float(0.5, Math.log2(Math.exp2(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.log2(Math.exp2(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.log2(Math.exp2(2.0)), 1.0e-6)
    assert_equal_float(0.5, Math.exp2(Math.log2(0.5)), 1.0e-6)
    assert_equal_float(1.0, Math.exp2(Math.log2(1.0)), 1.0e-6)
    assert_equal_float(2.0, Math.exp2(Math.log2(2.0)), 1.0e-6)

  end

  def test_pwr_consistency

    # Check complementarity of pow and root
    assert_equal_float(           4.0, Math.root(Math.pow(2.0, 6.0), 3.0), 1.0e-6)
    assert_equal_float(           2.0, Math.root(Math.pow(4.0, 4.0), 8.0), 1.0e-6)
    assert_equal_float(Math.sqrt(2.0), Math.pow(Math.root(2.0, 6.0), 3.0), 1.0e-6)
    assert_equal_float(          16.0, Math.pow(Math.root(4.0, 4.0), 8.0), 1.0e-6)

    # Check complementarity of sqrt and sqr
    assert_equal_float(0.3, Math.sqrt(Math.sqr( 0.3)), 1.0e-6)
    assert_equal_float(0.3, Math.sqrt(Math.sqr(-0.3)), 1.0e-6)
    assert_equal_float(0.3, Math.sqr(Math.sqrt( 0.3)), 1.0e-6)

  end

  def test_misc_consistency

    # Check complimentarity of erf and erfc
    assert_equal_float(1.0, Math.erf(1.0) + Math.erfc(1.0), 1.0e-6)
    assert_equal_float(1.0, Math.erf(2.0) + Math.erfc(2.0), 1.0e-6)
    assert_equal_float(1.0, Math.erf(3.0) + Math.erfc(3.0), 1.0e-6)
    assert_equal_float(1.0, Math.erf(4.0) + Math.erfc(4.0), 1.0e-6)

  end

end

