require 'runit/testcase'
require 'runit/cui/testrunner'
require 'runit/testsuite'
require './lib/extmath'

class Testing_class < RUNIT::TestCase

  def test_constants

    assert_equal(Math::E,  Extmath::E)
    assert_equal(Math::PI, Extmath::PI)
    assert_equal_float(0.577_215_664_901_532_861, Extmath::C, 1.0e-18)

  end

  def test_sign_functions

    # Check behavior of abs
    assert_equal(3.1, Extmath.abs(-3.1))
    assert_equal(0.0, Extmath.abs( 0.0))
    assert_equal(3.1, Extmath.abs( 3.1))

    # Check behavior of sign
    assert_equal(-1.0, Extmath.sign(-3.1))
    assert_equal( 0.0, Extmath.sign( 0.0))
    assert_equal( 1.0, Extmath.sign( 3.1))

  end

  def test_trigonometric_functions

    # Check identity of Extmath.acsc(x) and Math.asin(1/x)
    assert_equal_float(Math.asin(-1.0), Extmath.acsc(-1.0), 1.0e-6)
    assert_equal_float(Math.asin(-0.5), Extmath.acsc(-2.0), 1.0e-6)
    assert_equal_float(Math.asin( 0.5), Extmath.acsc( 2.0), 1.0e-6)
    assert_equal_float(Math.asin( 1.0), Extmath.acsc( 1.0), 1.0e-6)

    # Check identity of Extmath.acos and Math.acos
    assert_equal(Math.acos(-1.0), Extmath.acos(-1.0))
    assert_equal(Math.acos( 1.0), Extmath.acos( 1.0))

    # Check behavior of acot
    assert_equal_float(0.5 * Math::PI - Math.atan(-1.0), Extmath.acot(-1.0), 1.0e-6)
    assert_equal_float(0.5 * Math::PI - Math.atan( 1.0), Extmath.acot( 1.0), 1.0e-6)

    # Check identity of Extmath.asec(x) and Math.acos(1/x)
    assert_equal_float(Math.acos(-1.0), Extmath.asec(-1.0), 1.0e-6)
    assert_equal_float(Math.acos(-0.5), Extmath.asec(-2.0), 1.0e-6)
    assert_equal_float(Math.acos( 0.5), Extmath.asec( 2.0), 1.0e-6)
    assert_equal_float(Math.acos( 1.0), Extmath.asec( 1.0), 1.0e-6)

    # Check identity of Extmath.asin and Math.asin
    assert_equal(Math.asin(-1.0), Extmath.asin(-1.0))
    assert_equal(Math.asin( 1.0), Extmath.asin( 1.0))

    # Check identity of Extmath.atan and Math.atan
    assert_equal(Math.atan(-1.0), Extmath.atan(-1.0))
    assert_equal(Math.atan( 1.0), Extmath.atan( 1.0))

    # Check identity of Extmath.atan2 and Math.atan2
    assert_equal(Math.atan2(-3.1, 3.1), Extmath.atan2(-3.1, 3.1))
    assert_equal(Math.atan2( 3.1, 3.1), Extmath.atan2( 3.1, 3.1))

    # Check identity of Extmath.cos and Math.cos
    assert_equal(Math.cos(-1.0), Extmath.cos(-1.0))
    assert_equal(Math.cos( 1.0), Extmath.cos( 1.0))

    # Check identity of Extmath.asin and 1.0 / Math.sin
    assert_equal(1.0 / Math.sin(-1.0), Extmath.csc(-1.0))
    assert_equal(1.0 / Math.sin( 1.0), Extmath.csc( 1.0))

    # Check identity of Extmath.cot and 1.0 / Math.tan
    assert_equal_float(1.0 / Math.tan(1.0), Extmath.cot(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.tan(2.0), Extmath.cot(2.0), 1.0e-6)

    # Check identity of Extmath.sec and 1.0 / Math.cos
    assert_equal_float(1.0 / Math.cos(1.0), Extmath.sec(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.cos(2.0), Extmath.sec(2.0), 1.0e-6)

    # Check identity of Extmath.sin and Math.sin
    assert_equal(Math.sin(-1.0), Extmath.sin(-1.0))
    assert_equal(Math.sin( 1.0), Extmath.sin( 1.0))

    # Check identity of Extmath.tan and Math.tan
    assert_equal(Math.tan(-1.0), Extmath.tan(-1.0))
    assert_equal(Math.tan( 1.0), Extmath.tan( 1.0))

  end

  def test_hyperbolic_functions

    # Check behavior of acsch
    assert_equal_float(-0.881_373_6, Extmath.acsch(-1.0), 1.0e-6)
    assert_equal_float(-1.443_635_5, Extmath.acsch(-0.5), 1.0e-6)
    assert_equal_float( 1.443_635_5, Extmath.acsch( 0.5), 1.0e-6)
    assert_equal_float( 0.881_373_6, Extmath.acsch( 1.0), 1.0e-6)

    # Check identity of Extmath.acosh and Math.acosh
    assert_equal(Math.acosh(1.0), Extmath.acosh(1.0))
    assert_equal(Math.acosh(2.0), Extmath.acosh(2.0))

    # Check behavior of acoth
    assert_equal_float(0.5 * Math.log(5.0), Extmath.acoth(1.5), 1.0e-6)
    assert_equal_float(0.5 * Math.log(1.5), Extmath.acoth(5.0), 1.0e-6)

    # Check behavior of asech
    assert_equal_float(2.993_222_8, Extmath.asech(0.1), 1.0e-6)
    assert_equal_float(1.098_612_2, Extmath.asech(0.6), 1.0e-6)
    assert_equal_float(0.0,         Extmath.asech(1.0), 1.0e-6)

    # Check identity of Extmath.asinh and Math.asinh
    assert_equal(Math.asinh(-1.0), Extmath.asinh(-1.0))
    assert_equal(Math.asinh( 1.0), Extmath.asinh( 1.0))

    # Check identity of Extmath.atanh and Math.atanh
    assert_equal(Math.atanh(-0.5), Extmath.atanh(-0.5))
    assert_equal(Math.atanh( 0.5), Extmath.atanh( 0.5))

    # Check identity of Extmath.acsch and 1.0 / Math.sinh
    assert_equal(1.0 / Math.sinh(-1.0), Extmath.csch(-1.0))
    assert_equal(1.0 / Math.sinh( 1.0), Extmath.csch( 1.0))

    # Check identity of Extmat.cosh and Math.cosh
    assert_equal(Math.cosh(-1.0), Extmath.cosh(-1.0))
    assert_equal(Math.cosh( 1.0), Extmath.cosh( 1.0))

    # Check identity of Extmat.coth and 1.0 / Math.tanh
    assert_equal_float(1.0 / Math.tanh(1.0), Extmath.coth(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.tanh(2.0), Extmath.coth(2.0), 1.0e-6)

    # Check identity of Extmat.sech and 1.0 / Math.cosh
    assert_equal_float(1.0 / Math.cosh(1.0), Extmath.sech(1.0), 1.0e-6)
    assert_equal_float(1.0 / Math.cosh(2.0), Extmath.sech(2.0), 1.0e-6)

    # Check identity of Extmat.sinh and Math.sinh
    assert_equal(Math.sinh(-1.0), Extmath.sinh(-1.0))
    assert_equal(Math.sinh( 1.0), Extmath.sinh( 1.0))

    # Check identity of Extmat.tanh and Math.tanh
    assert_equal(Math.tanh(-1.0), Extmath.tanh(-1.0))
    assert_equal(Math.tanh( 1.0), Extmath.tanh( 1.0))

  end

  def test_explog_functions

    # Check behavior of exp
    assert_equal_float(               1.0, Extmath.exp(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(Math::E), Extmath.exp(0.5), 1.0e-6)
    assert_equal_float(           Math::E, Extmath.exp(1.0), 1.0e-6)

    # Check behavior of exp10
    assert_equal_float(            1.0, Extmath.exp10(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(10.0), Extmath.exp10(0.5), 1.0e-6)
    assert_equal_float(           10.0, Extmath.exp10(1.0), 1.0e-6)

    # Check behavior of exp2
    assert_equal_float(           1.0, Extmath.exp2(0.0), 1.0e-6)
    assert_equal_float(Math.sqrt(2.0), Extmath.exp2(0.5), 1.0e-6)
    assert_equal_float(           2.0, Extmath.exp2(1.0), 1.0e-6)

    # Check behavior of frexp
    assert_equal([-0.996_093_75, 8], Extmath.frexp(-255.0))
    assert_equal([-0.5,          1], Extmath.frexp(  -1.0))
    assert_equal([ 0.0,          0], Extmath.frexp(   0.0))
    assert_equal([ 0.5,          1], Extmath.frexp(   1.0))
    assert_equal([ 0.996_093_75, 8], Extmath.frexp( 255.0))

    # Check behavior of ldexp
    assert_equal_float(1.0, Extmath.ldexp(0.25, 2), 1.0e-6)
    assert_equal_float(1.0, Extmath.ldexp(0.5,  1), 1.0e-6)
    assert_equal_float(1.0, Extmath.ldexp(2,   -1), 1.0e-6)
    assert_equal_float(1.0, Extmath.ldexp(4,   -2), 1.0e-6)

    # Check identity of Extmat.log and Math.log
    assert_equal(Math.log(2.0), Extmath.log(2.0))
    assert_equal(Math.log(3.0), Extmath.log(3.0))

    # Check identity of Extmat.log10 and Math.log10
    assert_equal(Math.log10(2.0), Extmath.log10(2.0))
    assert_equal(Math.log10(3.0), Extmath.log10(3.0))

    # Check behavior of log2
    assert_equal_float(0.5, Extmath.log2(Math.sqrt(2.0)), 1.0e-6)
    assert_equal_float(1.0,            Extmath.log2(2.0), 1.0e-6)
    assert_equal_float(2.0,            Extmath.log2(4.0), 1.0e-6)

  end

  def test_pwr_functions

    # Check behavior of pow
    assert_equal_float(64.0,   Extmath.pow( 4.0,        3.0), 1.0e-6)
    assert_equal_float( 0.729, Extmath.pow( 0.9,        3.0), 1.0e-6)
    assert_equal_float( 0.25,  Extmath.pow(64.0, -1.0 / 3.0), 1.0e-6)
    assert_equal_float( 2.0,   Extmath.pow( 0.25,      -0.5), 1.0e-6)

    # Check behavior of root
    assert_equal_float( 4.0,  Extmath.root(64.0,          3.0), 1.0e-6)
    assert_equal_float( 0.9,  Extmath.root( 0.729,        3.0), 1.0e-6)
    assert_equal_float(64.0,  Extmath.root( 0.25,  -1.0 / 3.0), 1.0e-6)
    assert_equal_float( 0.25, Extmath.root( 2.0,         -0.5), 1.0e-6)

    # Check behavior of sqr
    assert_equal_float(0.81, Extmath.sqr(-0.9), 1.0e-6)
    assert_equal_float(0.49, Extmath.sqr(-0.7), 1.0e-6)
    assert_equal_float(0.49, Extmath.sqr(-0.7), 1.0e-6)
    assert_equal_float(0.81, Extmath.sqr( 0.9), 1.0e-6)

    # Check behavior of sqrt
    assert_equal_float(0.7, Extmath.sqrt(0.49), 1.0e-6)
    assert_equal_float(0.9, Extmath.sqrt(0.81), 1.0e-6)

  end

  def test_rounding_functions

    # Check behavior of ceil
    assert_equal( 2, Extmath.ceil( 1.999_99))
    assert_equal( 2, Extmath.ceil( 1.5))
    assert_equal( 2, Extmath.ceil( 1.000_01))
    assert_equal( 1, Extmath.ceil( 0.999_99))
    assert_equal( 1, Extmath.ceil( 0.5))
    assert_equal( 1, Extmath.ceil( 0.000_01))
    assert_equal( 0, Extmath.ceil(-0.000_01))
    assert_equal( 0, Extmath.ceil(-0.5))
    assert_equal( 0, Extmath.ceil(-0.999_99))
    assert_equal(-1, Extmath.ceil(-1.000_01))
    assert_equal(-1, Extmath.ceil(-1.5))
    assert_equal(-1, Extmath.ceil(-1.999_99))

    # Check behavior of floor
    assert_equal( 1, Extmath.floor( 1.999_99))
    assert_equal( 1, Extmath.floor( 1.5))
    assert_equal( 1, Extmath.floor( 1.000_01))
    assert_equal( 0, Extmath.floor( 0.999_99))
    assert_equal( 0, Extmath.floor( 0.5))
    assert_equal( 0, Extmath.floor( 0.000_01))
    assert_equal(-1, Extmath.floor(-0.000_01))
    assert_equal(-1, Extmath.floor(-0.5))
    assert_equal(-1, Extmath.floor(-0.999_99))
    assert_equal(-2, Extmath.floor(-1.000_01))
    assert_equal(-2, Extmath.floor(-1.5))
    assert_equal(-2, Extmath.floor(-1.999_99))

    # Check behavior of round
    assert_equal( 2, Extmath.round( 1.5))
    assert_equal( 1, Extmath.round( 1.4))
    assert_equal( 1, Extmath.round( 0.5))
    assert_equal( 0, Extmath.round( 0.4))
    assert_equal( 0, Extmath.round(-0.4))
    assert_equal(-1, Extmath.round(-0.5))
    assert_equal(-1, Extmath.round(-1.4))
    assert_equal(-2, Extmath.round(-1.5))

  end

  def test_tensors

    1.upto(3) { |i|
      1.upto(3) { |j|
        assert_equal(i == j ? 1 : 0, Extmath.delta(i, j))
      }
    }

    1.upto(3) { |i|
      1.upto(3) { |j|
        1.upto(3) { |k|
          case [i,j,k]
            when [1,2,3] then assert_equal( 1, Extmath.epsilon(i, j, k))
            when [1,3,2] then assert_equal(-1, Extmath.epsilon(i, j, k))
            when [2,1,3] then assert_equal(-1, Extmath.epsilon(i, j, k))
            when [2,3,1] then assert_equal( 1, Extmath.epsilon(i, j, k))
            when [3,1,2] then assert_equal( 1, Extmath.epsilon(i, j, k))
            when [3,2,1] then assert_equal(-1, Extmath.epsilon(i, j, k))
            else              assert_equal( 0, Extmath.epsilon(i, j, k))
          end
        }
      }
    }

  end

  def test_solvers

    ###############################################################################################################################
    # Check linsolve
    ###############################################################################################################################

    assert_nil(Extmath.linsolve(0.0, 1.0, 1.0))
    assert_nil(Extmath.linsolve(0.0, 2.0))

    assert_equal_float( 1.0, Extmath.linsolve(3.0,  6.0, 9.0), 1.0e-6)
    assert_equal_float(-3.0, Extmath.linsolve(9.0, 27.0, 0.0), 1.0e-6)
    assert_equal_float(-3.0, Extmath.linsolve(9.0, 27.0),      1.0e-6)

    assert_equal(Extmath.linsolve(7.0, 21.0, 0.0), Extmath.linsolve(7.0, 21.0))

    ###############################################################################################################################
    # Check sqsolve
    ###############################################################################################################################

    assert_equal(nil, Extmath.sqsolve(0.0, 0.0, 1.0, 1.0))
    assert_equal(nil, Extmath.sqsolve(0.0, 0.0, 2.0))
    assert_equal(nil, Extmath.sqsolve(7.0, 0.0, 5.0, 3.0))

    assert_equal(Array, Extmath.sqsolve(0.0,  3.0,   6.0,  9.0).class)
    assert_equal(Array, Extmath.sqsolve(0.0,  9.0,  27.0,  0.0).class)
    assert_equal(Array, Extmath.sqsolve(0.0,  9.0,  27.0      ).class)
    assert_equal(Array, Extmath.sqsolve(7.0,  0.0,   3.0,  3.0).class)
    assert_equal(Array, Extmath.sqsolve(2.0, -3.0,   3.0,  3.0).class)
    assert_equal(Array, Extmath.sqsolve(4.0,  0.0,   1.0, 15.0).class)
    assert_equal(Array, Extmath.sqsolve(3.0,  6.0,   1.0, -2.0).class)
    assert_equal(Array, Extmath.sqsolve(9.0, 18.0,   6.0,  6.0).class)
    assert_equal(Array, Extmath.sqsolve(3.0,  6.0, -21.0,  0.0).class)

    assert_equal(1, Extmath.sqsolve(0.0,  3.0,   6.0,  9.0).length)
    assert_equal(1, Extmath.sqsolve(0.0,  9.0,  27.0,  0.0).length)
    assert_equal(1, Extmath.sqsolve(0.0,  9.0,  27.0      ).length)
    assert_equal(2, Extmath.sqsolve(7.0,  0.0,   3.0,  3.0).length)
    assert_equal(2, Extmath.sqsolve(2.0, -3.0,   3.0,  3.0).length)
    assert_equal(2, Extmath.sqsolve(4.0,  0.0,   1.0, 15.0).length)
    assert_equal(2, Extmath.sqsolve(3.0,  6.0,   1.0, -2.0).length)
    assert_equal(2, Extmath.sqsolve(9.0, 18.0,   6.0,  6.0).length)
    assert_equal(2, Extmath.sqsolve(9.0,  6.0, -21.0,  0.0).length)

    assert_equal(Extmath.sqsolve(0.0, 7.0, 21.0, 0.0), Extmath.sqsolve(0.0, 7.0, 21.0))
    assert_equal(Extmath.sqsolve(2.0, 3.0,  4.0, 4.0), Extmath.sqsolve(2.0, 3.0,  0.0))

    assert_equal_float( 1.0,                Extmath.sqsolve(0.0,  3.0,   6.0,  9.0)[0], 1.0e-6)
    assert_equal_float(-3.0,                Extmath.sqsolve(0.0,  9.0,  27.0,  0.0)[0], 1.0e-6)
    assert_equal_float(-3.0,                Extmath.sqsolve(0.0,  9.0,  27.0      )[0], 1.0e-6)
    assert_equal_float( 0.0,                Extmath.sqsolve(7.0,  0.0,   3.0,  3.0)[0], 1.0e-6)
    assert_equal_float( 0.0,                Extmath.sqsolve(2.0, -3.0,   3.0,  3.0)[0], 1.0e-6)
    assert_equal_float(-2.0,                Extmath.sqsolve(4.0,  0.0,  -1.0, 15.0)[0], 1.0e-6)
    assert_equal_float(-1.0,                Extmath.sqsolve(3.0,  6.0,   1.0, -2.0)[0], 1.0e-6)
    assert_equal_float(-2.0,                Extmath.sqsolve(9.0, 18.0,   6.0,  6.0)[0], 1.0e-6)
    assert_equal_float(-1.0 - Math.sqrt(8), Extmath.sqsolve(3.0,  6.0, -21.0,  0.0)[0], 1.0e-6)

    assert_equal_float(0.0,                 Extmath.sqsolve(7.0,  0.0,   3.0,  3.0)[1], 1.0e-6)
    assert_equal_float(1.5,                 Extmath.sqsolve(2.0, -3.0,   3.0,  3.0)[1], 1.0e-6)
    assert_equal_float(2.0,                 Extmath.sqsolve(4.0,  0.0,  -1.0, 15.0)[1], 1.0e-6)
    assert_equal_float(-1.0,                Extmath.sqsolve(3.0,  6.0,   1.0, -2.0)[1], 1.0e-6)
    assert_equal_float( 0.0,                Extmath.sqsolve(9.0, 18.0,   6.0,  6.0)[1], 1.0e-6)
    assert_equal_float(-1.0 + Math.sqrt(8), Extmath.sqsolve(3.0,  6.0, -21.0,  0.0)[1], 1.0e-6)

  end

  def test_conversions

    assert_equal_float( 90.0,               Extmath.rad2deg(0.5 * Extmath::PI), 1.0e-6)
    assert_equal_float(180.0 / Extmath::PI, Extmath.rad2deg(1.0),               1.0e-6)

    assert_equal_float(100.0,               Extmath.rad2gon(0.5 * Extmath::PI), 1.0e-6)
    assert_equal_float(200.0 / Extmath::PI, Extmath.rad2gon(1.0),               1.0e-6)

    assert_equal_float( 0.5 * Extmath::PI,       Extmath.deg2rad( 90.0), 1.0e-6)
    assert_equal_float(10.0 * Extmath::PI / 9.0, Extmath.deg2rad(200.0), 1.0e-6)

    assert_equal_float( 100.0,       Extmath.deg2gon( 90.0), 1.0e-6)
    assert_equal_float(2000.0 / 9.0, Extmath.deg2gon(200.0), 1.0e-6)

    assert_equal_float(0.5  * Extmath::PI, Extmath.gon2rad(100.0), 1.0e-6)
    assert_equal_float(0.21 * Extmath::PI, Extmath.gon2rad( 42.0), 1.0e-6)

    assert_equal_float(90.0, Extmath.gon2deg(100.0), 1.0e-6)
    assert_equal_float(37.8, Extmath.gon2deg( 42.0), 1.0e-6)

  end

  def test_misc_functions

    # Check behavior of beta
    assert_equal_float( 1.0,        Extmath.beta(1.0, 1.0), 1.0e-6)
    assert_equal_float( 0.5,        Extmath.beta(1.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 /  3.0, Extmath.beta(1.0, 3.0), 1.0e-6)
    assert_equal_float( 0.5,        Extmath.beta(2.0, 1.0), 1.0e-6)
    assert_equal_float( 1.0 /  6.0, Extmath.beta(2.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 / 12.0, Extmath.beta(2.0, 3.0), 1.0e-6)
    assert_equal_float( 1.0 /  3.0, Extmath.beta(3.0, 1.0), 1.0e-6)
    assert_equal_float( 1.0 / 12.0, Extmath.beta(3.0, 2.0), 1.0e-6)
    assert_equal_float( 1.0 / 30.0, Extmath.beta(3.0, 3.0), 1.0e-6)

    # Check behavior of erf and erfc
    assert_equal_float(0.0, Extmath.erf(0.0),  1.0e-6)
    assert_equal_float(1.0, Extmath.erfc(0.0), 1.0e-6)

    # Check behavior of factorial
    fac = 1
    1.upto(100) {|i|
      fac *= i
      assert_equal(fac, Extmath.factorial(i))
    }

    # Check behavior of tgamma (assert data that can be found in Bronstein-Semendjajew).
    assert_equal_float(1.000_00, Extmath.tgamma(1.00), 1.0e-5)
    assert_equal_float(0.947_40, Extmath.tgamma(1.11), 1.0e-5)
    assert_equal_float(0.913_11, Extmath.tgamma(1.22), 1.0e-5)
    assert_equal_float(0.893_38, Extmath.tgamma(1.33), 1.0e-5)
    assert_equal_float(0.885_81, Extmath.tgamma(1.44), 1.0e-5)
    assert_equal_float(0.888_87, Extmath.tgamma(1.55), 1.0e-5)
    assert_equal_float(0.901_67, Extmath.tgamma(1.66), 1.0e-5)
    assert_equal_float(0.923_76, Extmath.tgamma(1.77), 1.0e-5)
    assert_equal_float(0.955_07, Extmath.tgamma(1.88), 1.0e-5)
    assert_equal_float(0.995_81, Extmath.tgamma(1.99), 1.0e-5)

    # Check behavior of gcd
    assert_equal(                   4,    Extmath.gcd(                4_732, 4_700))
    assert_equal(                   1,    Extmath.gcd(                3_651, 5_023))
    assert_equal(Extmath.factorial(47),   Extmath.gcd(Extmath.factorial(90), Extmath.factorial(47)))
    assert_equal(              5_565_651, Extmath.gcd(          612_221_610, 67_461_255_771))

    # Check behavior of hypoth
    assert_equal_float(Math.sqrt( 5.0), Extmath.hypot(1.0, 2.0), 1.0e-6)
    assert_equal_float(Math.sqrt(13.0), Extmath.hypot(2.0, 3.0), 1.0e-6)
    assert_equal_float(            5.0, Extmath.hypot(3.0, 4.0), 1.0e-6)

    # Check behavior of lcm
    assert_equal(17_017, Extmath.lcm( 77, 221))
    assert_equal( 2_431, Extmath.lcm(143, 187))
    assert_equal( 1_547, Extmath.lcm( 91, 119))

    # Check behavior of lgamma
    assert_equal_float(               0.0, Extmath.lgamma(2.0), 1.0e-6)
    assert_equal_float(Extmath.log(  2.0), Extmath.lgamma(3.0), 1.0e-6)
    assert_equal_float(Extmath.log(  6.0), Extmath.lgamma(4.0), 1.0e-6)
    assert_equal_float(Extmath.log( 24.0), Extmath.lgamma(5.0), 1.0e-6)
    assert_equal_float(Extmath.log(120.0), Extmath.lgamma(6.0), 1.0e-6)
    assert_equal_float(Extmath.log(720.0), Extmath.lgamma(7.0), 1.0e-6)

    # Check behavior of sinc
    assert_equal_float(                1.0, Extmath.sinc( 0.0), 0.0)
    assert_equal_float(      Math.sin(1.0), Extmath.sinc( 1.0), 0.0)
    assert_equal_float(      Math.sin(1.0), Extmath.sinc(-1.0), 0.0)
    assert_equal_float(0.5 * Math.sin(2.0), Extmath.sinc( 2.0), 0.0)
    assert_equal_float(0.5 * Math.sin(2.0), Extmath.sinc(-2.0), 0.0)

  end

  def test_sign_consistency

    # Check complementarity of abs and sign
    assert_equal_float(-2.0, Extmath.abs(-2.0) * Extmath.sign(-2.0), 1e-6)
    assert_equal_float( 0.0, Extmath.abs( 0.0) * Extmath.sign( 0.0), 1e-6)
    assert_equal_float( 3.0, Extmath.abs( 3.0) * Extmath.sign( 3.0), 1e-6)

  end

  def test_trigonometric_consistency

    # Check complementarity of acos and cos
    assert_equal_float( 0.5, Extmath.acos(Extmath.cos(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.cos(Extmath.acos(-0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.acos(Extmath.cos( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.cos(Extmath.acos( 0.5)), 1.0e-6)

    # Check complementarity of acot and cot
    assert_equal_float(1.0, Extmath.acot(Extmath.cot(1.0)), 1.0e-6)
    assert_equal_float(1.0, Extmath.cot(Extmath.acot(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.acot(Extmath.cot(2.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.cot(Extmath.acot(2.0)), 1.0e-6)

    # Check complementarity of acsc and csc
    assert_equal_float(-0.5, Extmath.acsc(Extmath.csc(-0.5)), 1.0e-6)
    assert_equal_float(-2.0, Extmath.csc(Extmath.acsc(-2.0)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.acsc(Extmath.csc( 0.5)), 1.0e-6)
    assert_equal_float( 2.0, Extmath.csc(Extmath.acsc( 2.0)), 1.0e-6)

    # Check complementarity of asec and sec
    assert_equal_float( 0.5, Extmath.asec(Extmath.sec(-0.5)), 1.0e-6)
    assert_equal_float(-2.0, Extmath.sec(Extmath.asec(-2.0)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.asec(Extmath.sec( 0.5)), 1.0e-6)
    assert_equal_float( 2.0, Extmath.sec(Extmath.asec( 2.0)), 1.0e-6)

    # Check complementarity of asin and sin
    assert_equal_float( 0.5, Extmath.asin(Extmath.sin( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.sin(Extmath.asin( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.asin(Extmath.sin(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.sin(Extmath.asin(-0.5)), 1.0e-6)

    # Check consistency of atan2 and acot
    assert_equal_float(Extmath.atan2(1.0, 1.0), Extmath.acot(1.0), 1.0e-6)
    assert_equal_float(Extmath.atan2(1.0, 2.0), Extmath.acot(2.0), 1.0e-6)

    # Check consistency of atan2 and atan
    assert_equal_float(Extmath.atan2(-3.1, 3.1), Extmath.atan(-1.0), 1.0e-6)
    assert_equal_float(Extmath.atan2( 3.1, 3.1), Extmath.atan( 1.0), 1.0e-6)

    # Check complementarity of atan and tan
    assert_equal_float( 0.5, Extmath.atan(Extmath.tan( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.tan(Extmath.atan( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.atan(Extmath.tan(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.tan(Extmath.atan(-0.5)), 1.0e-6)

    # Check complementarity of cos and sec
    assert_equal_float(1.0, Extmath.sec(-2.0) * Extmath.cos(-2.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sec(-1.0) * Extmath.cos(-1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sec( 1.0) * Extmath.cos( 1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sec( 2.0) * Extmath.cos( 2.0), 1.0e-6)

    # Check complementarity of csc and sin
    assert_equal_float(1.0, Extmath.csc(-2.0) * Extmath.sin(-2.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csc(-1.0) * Extmath.sin(-1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csc( 1.0) * Extmath.sin( 1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csc( 2.0) * Extmath.sin( 2.0), 1.0e-6)

  end

  def test_hyperbolic_consistency

    # Check complimentarity of acsch and csch
    assert_equal_float(-1.0, Extmath.csch(Extmath.acsch(-1.0)), 1.0e-6)
    assert_equal_float(-1.0, Extmath.acsch(Extmath.csch(-1.0)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.csch(Extmath.acsch(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.acsch(Extmath.csch(-0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.csch(Extmath.acsch( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.acsch(Extmath.csch( 0.5)), 1.0e-6)
    assert_equal_float( 1.0, Extmath.csch(Extmath.acsch( 1.0)), 1.0e-6)
    assert_equal_float( 1.0, Extmath.acsch(Extmath.csch( 1.0)), 1.0e-6)

    # Check complementarity of acosh and cosh
    assert_equal_float(1.5, Extmath.acosh(Extmath.cosh( 1.5)), 1.0e-6)
    assert_equal_float(1.5, Extmath.cosh(Extmath.acosh( 1.5)), 1.0e-6)
    assert_equal_float(1.5, Extmath.acosh(Extmath.cosh(-1.5)), 1.0e-6)

    # Check complementarity of acoth and coth
    assert_equal_float( 1.5, Extmath.acoth(Extmath.coth( 1.5)), 1.0e-6)
    assert_equal_float( 1.5, Extmath.coth(Extmath.acoth( 1.5)), 1.0e-6)
    assert_equal_float(-1.5, Extmath.acoth(Extmath.coth(-1.5)), 1.0e-6)
    assert_equal_float(-1.5, Extmath.coth(Extmath.acoth(-1.5)), 1.0e-6)

    # Check complimentarity of asech and sech
    assert_equal_float( 0.1, Extmath.sech(Extmath.asech(0.1)), 1.0e-6)
    assert_equal_float( 0.1, Extmath.asech(Extmath.sech(0.1)), 1.0e-6)
    assert_equal_float( 0.6, Extmath.sech(Extmath.asech(0.6)), 1.0e-6)
    assert_equal_float( 0.6, Extmath.asech(Extmath.sech(0.6)), 1.0e-6)
    assert_equal_float( 1.0, Extmath.sech(Extmath.asech(1.0)), 1.0e-6)
    assert_equal_float( 1.0, Extmath.asech(Extmath.sech(1.0)), 1.0e-6)

    # Check complementarity of asinh and sinh
    assert_equal_float( 1.5, Extmath.asinh(Extmath.sinh( 1.5)), 1.0e-6)
    assert_equal_float( 1.5, Extmath.sinh(Extmath.asinh( 1.5)), 1.0e-6)
    assert_equal_float(-1.5, Extmath.asinh(Extmath.sinh(-1.5)), 1.0e-6)
    assert_equal_float(-1.5, Extmath.sinh(Extmath.asinh(-1.5)), 1.0e-6)

    # Check complementarity of atanh and tanh
    assert_equal_float( 0.5, Extmath.atanh(Extmath.tanh( 0.5)), 1.0e-6)
    assert_equal_float( 0.5, Extmath.tanh(Extmath.atanh( 0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.atanh(Extmath.tanh(-0.5)), 1.0e-6)
    assert_equal_float(-0.5, Extmath.tanh(Extmath.atanh(-0.5)), 1.0e-6)

    # Check complementarity of csch and sinh
    assert_equal_float(1.0, Extmath.csch(-2.0) * Extmath.sinh(-2.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csch(-1.0) * Extmath.sinh(-1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csch( 1.0) * Extmath.sinh( 1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.csch( 2.0) * Extmath.sinh( 2.0), 1.0e-6)

    # Check complementarity of cosh and sech
    assert_equal_float(1.0, Extmath.sech(-2.0) * Extmath.cosh(-2.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sech(-1.0) * Extmath.cosh(-1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sech( 1.0) * Extmath.cosh( 1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.sech( 2.0) * Extmath.cosh( 2.0), 1.0e-6)

  end

  def test_explog_consistency

    # Check complementarity of exp and log
    assert_equal_float(0.5, Extmath.log(Extmath.exp(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.log(Extmath.exp(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.log(Extmath.exp(2.0)), 1.0e-6)
    assert_equal_float(0.5, Extmath.exp(Extmath.log(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.exp(Extmath.log(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.exp(Extmath.log(2.0)), 1.0e-6)

    # Check complementarity of exp10 and log10
    assert_equal_float(0.5, Extmath.log10(Extmath.exp10(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.log10(Extmath.exp10(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.log10(Extmath.exp10(2.0)), 1.0e-6)
    assert_equal_float(0.5, Extmath.exp10(Extmath.log10(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.exp10(Extmath.log10(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.exp10(Extmath.log10(2.0)), 1.0e-6)

    # Check complementarity of exp2 and log2
    assert_equal_float(0.5, Extmath.log2(Extmath.exp2(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.log2(Extmath.exp2(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.log2(Extmath.exp2(2.0)), 1.0e-6)
    assert_equal_float(0.5, Extmath.exp2(Extmath.log2(0.5)), 1.0e-6)
    assert_equal_float(1.0, Extmath.exp2(Extmath.log2(1.0)), 1.0e-6)
    assert_equal_float(2.0, Extmath.exp2(Extmath.log2(2.0)), 1.0e-6)

  end

  def test_pwr_consistency

    # Check complementarity of pow and root
    assert_equal_float(           4.0, Extmath.root(Extmath.pow(2.0, 6.0), 3.0), 1.0e-6)
    assert_equal_float(           2.0, Extmath.root(Extmath.pow(4.0, 4.0), 8.0), 1.0e-6)
    assert_equal_float(Math.sqrt(2.0), Extmath.pow(Extmath.root(2.0, 6.0), 3.0), 1.0e-6)
    assert_equal_float(          16.0, Extmath.pow(Extmath.root(4.0, 4.0), 8.0), 1.0e-6)

    # Check complementarity of sqrt and sqr
    assert_equal_float(0.3, Extmath.sqrt(Extmath.sqr( 0.3)), 1.0e-6)
    assert_equal_float(0.3, Extmath.sqrt(Extmath.sqr(-0.3)), 1.0e-6)
    assert_equal_float(0.3, Extmath.sqr(Extmath.sqrt( 0.3)), 1.0e-6)

  end

  def test_misc_consistency

    # Check complimentarity of erf and erfc
    assert_equal_float(1.0, Extmath.erf(1.0) + Extmath.erfc(1.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.erf(2.0) + Extmath.erfc(2.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.erf(3.0) + Extmath.erfc(3.0), 1.0e-6)
    assert_equal_float(1.0, Extmath.erf(4.0) + Extmath.erfc(4.0), 1.0e-6)

  end

end

RUNIT::CUI::TestRunner.run(Testing_class.suite)
