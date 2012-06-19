#!/usr/bin/env ruby
# Extmath version 2.3
# Extmath is a library (Ruby module) that extends Math.
# Copyright (C) 2003 Josef 'Jupp' Schugt <jupp@rubyforge.org>
#
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.

module Extmath

@@Inv_ln_2	  = 1.0 / Math.log(2.0)
@@PI_by_2	  = 0.5 * Math::PI
@@Gauss_factor  = Math.sqrt(0.5 / Math::PI)

@@Deg2gon = 10.0 / 9.0
@@Deg2rad = Math::PI / 180.0
@@Gon2deg = 0.9
@@Gon2rad = Math::PI / 200.0
@@Rad2deg = 180.0 / Math::PI
@@Rad2gon = 200.0 / Math::PI

@@factorials	  = [		    1,
				    1,
				    2,
				    6,
				   24,
				  120,
				  720,
				5_040,
			       40_320,
			      362_880,
			    3_628_800,
			   39_916_800,
			  479_001_600,
			6_227_020_800,
		       87_178_291_200,
		    1_307_674_368_000
		  ]

=begin
== Extmath version 2.3
=== Constants
[ ((<C|Extmath::C>)) | ((<E|Extmath::E>)) | ((<PI|Extmath::PI>)) ]
=== Methods
: Powers and roots
  [ ((<hypot|Extmath.hypot>)) | ((<pow|Extmath.pow>)) | ((<root|Extmath.root>)) | ((<sqr|Extmath.sqr>)) | ((<sqrt|Extmath.sqrt>)) ]
: Exponential and logarithmic functions
  [ ((<exp|Extmath.exp>)) | ((<exp10|Extmath.exp10>)) | ((<exp2|Extmath.exp2>)) | ((<frexp|Extmath.frexp>)) |
  ((<ldexp|Extmath.ldexp>)) | ((<log|Extmath.log>)) | ((<log10|Extmath.log10>)) | ((<log2|Extmath.log2>)) ]
: Trigonometric functions
  [ ((<acos|Extmath.acos>)) | ((<acot|Extmath.acot>)) | ((<acsc|Extmath.acsc>)) | ((<asec|Extmath.asec>)) | ((<asin|Extmath.asin>))
  | ((<atan|Extmath.atan>)) | ((<atan2|Extmath.atan2>)) | ((<cos|Extmath.cos>)) | ((<cot|Extmath.cot>)) | ((<csc|Extmath.csc>)) |
  ((<sec|Extmath.sec>)) | ((<sin|Extmath.sin>)) | ((<tan|Extmath.tan>)) ]
: Hyperbolic functions
  [ ((<acosh|Extmath.acosh>)) | ((<acoth|Extmath.acoth>)) | ((<acsch|Extmath.acsch>)) | ((<asech|Extmath.asech>)) |
  ((<asinh|Extmath.asinh>)) | ((<atanh|Extmath.atanh>)) | ((<cosh|Extmath.cosh>)) | ((<coth|Extmath.coth>)) |
  ((<csch|Extmath.csch>)) | ((<sech|Extmath.sech>)) | ((<sinh|Extmath.sinh>)) | ((<tanh|Extmath.tanh>)) ]
: Conversion between degree, gon and radian
  [ ((<deg2gon|Extmath.deg2gon>)) | ((<deg2rad|Extmath.deg2rad>)) | ((<gon2deg|Extmath.gon2deg>)) | ((<gon2rad|Extmath.gon2rad>)) |
  ((<rad2deg|Extmath.rad2deg>)) | ((<rad2gon|Extmath.rad2gon>)) ]
: Special functions
  [ ((<beta|Extmath.beta>)) | ((<erf|Extmath.erf>)) | ((<erfc|Extmath.erfc>)) | ((<lgamma|Extmath.lgamma>)) |
  ((<sinc|Extmath.sinc>)) | ((<tgamma|Extmath.tgamma>)) ]
: Absolute value, sign and rounding
  [ ((<abs|Extmath.abs>)) | ((<ceil|Extmath.ceil>)) | ((<floor|Extmath.floor>)) | ((<round|Extmath.round>)) |
  ((<sign|Extmath.sign>)) ]
: Integer functions
  [ ((<delta|Extmath.delta>)) | ((<epsilon|Extmath.epsilon>)) | ((<factorial|Extmath.factorial>)) | ((<gcd|Extmath.gcd>)) |
  ((<lcm|Extmath.lcm>)) ]
: Solver
  [ ((<linsolve|Extmath.linsolve>)) | ((<sqsolve|Extmath.sqsolve>)) ]
=end

=begin
== Constants
--- Extmath::C
    Euler's constant ((*C*)), (({Extmath.C = 0.577_2...}))
=end
C = 0.577_215_664_901_532_861

=begin
--- Extmath::E
    Same as (({Math::E})) - Euler's number, (({Extmath.E = 2.718_182_8...}))
=end
E = Math::E

=begin
--- Extmath::PI
    Same as (({Math::PI})) - Ludolph's number, (({Extmath.PI = 3.141_59..})).
=end
PI = Math::PI

=begin
== Methods
--- Extmath.abs(x)
    Absolute value of ((|x|))
=end
def Extmath.abs(x)
  x.abs
end

=begin
--- Extmath.acos(x)
    Same as (({Math.acos(((|x|)))})) - arcus cotangens of ((|x|))
=end
def Extmath.acos(x)
  Math.acos(x)
end

=begin
--- Extmath.acosh(x)
    Same as (({Math.acosh(((|x|)))})) - area cosinus hyperbolicus of ((|x|))
=end
def Extmath.acosh(x)
  Math.acosh(x)
end

=begin
--- Extmath.acot(x)
    Arcus cotangens of ((|x|))
=end
def Extmath.acot(x)
  @@PI_by_2 - Math.atan(x)
end

=begin
--- Extmath.acoth(x)
    Area cotangens hyperbolicus of ((|x|))
=end
def Extmath.acoth(x)
  0.5 * Math.log((x + 1.0) / (x - 1.0))
end

=begin
--- Extmath.acsc(x)
    Arcus cosecans of ((|x|))
=end
def Extmath.acsc(x)
  Math.asin(1.0 / x)
end

=begin
--- Extmath.acsch(x)
    Area cosecans hyperbolicus of ((|x|))
=end
def Extmath.acsch(x)
  Math.log(1.0 / x + Math.sqrt(1.0 + 1.0 / (x * x)))
end

=begin
--- Extmath.asec(x)
    Arcus secans of ((|x|))
=end
def Extmath.asec(x)
  Math.acos(1.0 / x)
end

=begin
--- Extmath.asech(x)
    Area secans hyperbolicus of ((|x|))
=end
def Extmath.asech(x)
  Math.log((1.0 + Math.sqrt(1.0 - x * x)) / x)
end

=begin
--- Extmath.asin(x)
    Same as (({Math.asin(((|x|)))})) - arcus sinus of ((|x|))
=end
def Extmath.asin(x)
  Math.asin(x)
end

=begin
--- Extmath.asinh(x)
    Same as (({Math.sinh(((|x|)))})) - area sinus hyperbolicus of ((|x|))
=end
def Extmath.asinh(x)
  Math.asinh(x)
end

=begin
--- Extmath.atan(x)
    Same as (({Math.atan(((|x|)))})) - arcus tangens of ((|x|))
=end
def Extmath.atan(x)
  Math.atan(x)
end

=begin
--- Extmath.atan2(x, y)
    Same as (({Math.atan2(((|x|)), ((|y|)))})) - arcus tangens of ((|x|)) over
    ((|y|))
=end
def Extmath.atan2(x, y)
  Math.atan2(x, y)
end

=begin
--- Extmath.atanh(x)
    Same as (({Math.atanh(((|x|)))})) - area tangens hyperbolicus of ((|x|))
=end
def Extmath.atanh(x)
  Math.atanh(x)
end

=begin
--- Extmath.beta(x, y)
    Beta function of ((|x|)) and ((|y|)) - (({beta(((|x|)), ((|y|))) =
    tgamma(((|x|))) * tgamma(((|y|))) / tgamma(((|x|)) + ((|y|)))}))
=end
def Extmath.beta(x, y)
  Math.exp(Extmath.lgamma(x) + Extmath.lgamma(y) - Extmath.lgamma(x+y))
end

=begin
--- Extmath.ceil(x)
    Smallest integer not smaller than ((|x|))
=end
def Extmath.ceil(x)
  x.ceil
end

=begin
--- Extmath.cos(x)
    Same as (({Math.cos(((|x|)))})) - cosinus of ((|x|))
=end
def Extmath.cos(x)
  Math.cos(x)
end

=begin
--- Extmath.cosh(x)
    Same as (({Math.cosh(((|x|)))})) - cosinus hyperbolicus of ((|x|))
=end
def Extmath.cosh(x)
  Math.cosh(x)
end

=begin
--- Extmath.cot(x)
    Cotangens of ((|x|))
=end
def Extmath.cot(x)
  Math.tan(@@PI_by_2 - x)
end

=begin
--- Extmath.coth(x)
    Cotangens hyperbolicus of ((|x|))
=end
def Extmath.coth(x)
  1.0 / Math.tanh(x)
end

=begin
--- Extmath.csc(x)
    Cosecans of ((|x|))
=end
def Extmath.csc(x)
  1.0 / Math.sin(x)
end

=begin
--- Extmath.csch(x)
    Cosecans hyperbolicus of ((|x|))
=end
def Extmath.csch(x)
  1.0 / Math.sinh(x)
end

=begin
--- Extmath.deg2gon(x)
    Converts ((|x|)) form degree to gon
=end
def Extmath.deg2gon(x)
  return @@Deg2gon * x
end

=begin
--- Extmath.deg2rad(x)
    Converts ((|x|)) form degree to radian
=end
def Extmath.deg2rad(x)
  return @@Deg2rad * x
end

=begin
--- Extmath.delta(i, j)
    Kronecker symbol of ((|i|)) and ((|j|)) - 1 if ((|i|)) and ((|j|)) are equal, 0 otherwise
=end
def Extmath.delta(i, j)
  return Integer(i) == Integer(j) ? 1 : 0
end

=begin
--- Extmath.epsilon(i, j, k)
    Levi-Civita symbol of ((|i|)), ((|j|)), and ((|k|)) - 1 if (((|i|)), ((|j|)), ((|k|))) is (1, 2, 3), (2, 3, 1), or (3, 1, 2),
    -1 if it is (1, 3, 2), (2, 1, 3), or (3, 2, 1), 0 as long as ((|i|)), ((|j|)), and ((|k|)) are all elements of {1, 2, 3},
    otherwise returns (({nil})).
=end
def Extmath.epsilon(i, j, k)
  i = Integer(i)
  return nil if i < 1 or i > 3
  j = Integer(j)
  return nil if j < 1 or j > 3
  k = Integer(k)
  return nil if k < 1 or k > 3
  case i * 16 + j * 4 + k
    when 27, 45, 54 then return  1
    when 30, 39, 57 then return -1
  end
  0
end

=begin
--- Extmath.erf(x)
    Same as (({Math.erf(((|x|)))})) - Gauﬂian error integral up to ((|x|))
=end
def Extmath.erf(x)
  Math.erf(x)
end

=begin
--- Extmath.erfc(x)
    Same as (({Math.erfc(((|x|)))})) - complementary Gauﬂian error integral from ((|x|)) on
=end
def Extmath.erfc(x)
  Math.erfc(x)
end

=begin
--- Extmath.exp(x)
    Same as (({Math.exp(((|x|)))})) - e to the power ((|x|))
=end
def Extmath.exp(x)
  Math.exp(x)
end

=begin
--- Extmath.exp10(x)
    10 to the power ((|x|))
=end
def Extmath.exp10(x)
  10.0 ** x
end

=begin
--- Extmath.exp2(x)
    2 to the power ((|x|))
=end
def Extmath.exp2(x)
  2.0 ** x
end

=begin
--- Extmath.factorial(n)
    1 * 2 * ... * ((|n|)), (({nil})) for negative numbers
=end
def Extmath.factorial(n)
  n = Integer(n)
  if n < 0
    nil
  elsif @@factorials.length > n
    @@factorials[n]
  else
    h = @@factorials.last
    (@@factorials.length .. n).each { |i| @@factorials.push h *= i }
    h
  end
end

=begin
--- Extmath.floor(x)
    Largest integer not larger than ((|x|))
=end
def Extmath.floor(x)
  x.floor
end

=begin
--- Extmath.frexp(x)
    Same as (({Math.frexp(((|x|)))})) - two-element array containing the normalized fraction and exponent of ((|x|)).
=end
def Extmath.frexp(x)
  Math.frexp(x)
end

=begin
--- Extmath.gcd(m, n)
    Greatest common divisor of ((|m|)) and ((|n|)), (({nil})) for non-positive numbers - gcd is computed by means of the Euklidian
    algorithm
=end
def Extmath.gcd(m, n)
  m = Integer(m)
  n = Integer(n)
  if m <= 0 || n <= 0
    return nil
  end
  loop {
    if m < n
      m, n = n, m
    end
    if (l = m % n) == 0
      break
    end
    m = l
  }
  n
end

=begin
--- Extmath.gon2deg(x)
    Converts ((|x|)) form gon to degree
=end
def Extmath.gon2deg(x)
  return @@Gon2deg * x
end

=begin
--- Extmath.gon2rad(x)
    Converts ((|x|)) form gon to radian
=end
def Extmath.gon2rad(x)
  return @@Gon2rad * x
end

=begin
--- Extmath.hypot(x, y)
    Same as (({Math.hypot(((|x|)), ((|y|)))})) - length of hypotenuse of a rectangular triangle with sides ((|x|)) and ((|y|)).
=end
def Extmath.hypot(x, y)
  Math.hypot(x, y)
end

=begin
--- Extmath.lcm(m, n)
    Least common multiple of ((|m|)) and ((|n|)) - computed by multiplying ((|m|)) and ((|n|)) and dividing the product by the gcd
    of ((|m|)) and ((|n|)), (({nil})) for non-positive numbers.
=end
def Extmath.lcm(m, n)
  m = Integer(m)
  n = Integer(n)
  if m <= 0 || n <= 0
    return nil
  end
  m / gcd(m, n) * n
end

=begin
--- Extmath.ldexp(x, y)
    ((|x|)) times 2 to the power ((|y|))
=end
def Extmath.ldexp(x, y)
  Math.ldexp(x, y)
end

=begin
--- Extmath.lgamma(x)
    Logarithmus naturalis of gamma function of ((|x|))
=end
def Extmath.lgamma(x)
  h  = x + 5.5
  h -= (x + 0.5) * log(h)
  sum  =  1.000_000_000_190_015
  sum += 76.180_091_729_471_46	     / (x + 1.0)
  sum -= 86.505_320_329_416_77	     / (x + 2.0)
  sum += 24.014_098_240_830_91	     / (x + 3.0)
  sum -=  1.231_739_572_450_155	     / (x + 4.0)
  sum +=  0.120_865_097_386_617_9e-2 / (x + 5.0)
  sum -=  0.539_523_938_495_3e-5     / (x + 6.0)
  -h + log(2.506_628_274_631_000_5 * sum / x)
end

=begin
--- Extmath.linsolve(a, b, c)
    Returns real solution(s) of (({((|a|))x + ((|b|)) = ((|c|))})) or (({nil})) if no or an infinite number of solutions exist. If
    (({c})) is missing it is assumed to be 0.
=end
def Extmath.linsolve(a, b, c = 0.0)
  a == 0 ? nil : (c - b) / a
end

=begin
--- Extmath.log(x)
    Same as (({Math.log(((|x|)))})) - logarithmus naturalis of ((|x|))
=end
def Extmath.log(x)
  Math.log(x)
end

=begin
--- Extmath.log10(x)
    Same as (({Math.log10(((|x|)))})) - logarithmus decimalis of ((|x|))
=end
def Extmath.log10(x)
  Math.log10(x)
end

=begin
--- Extmath.log2(x)
    Logarithmus dualis of ((|x|))
=end
def Extmath.log2(x)
  Math.log(x) * @@Inv_ln_2
end

=begin
--- Extmath.pow(x, y)
    ((|x|)) to the power ((|y|))
=end
def Extmath.pow(x, y)
  x ** y
end

=begin
--- Extmath.rad2deg(x)
    Converts ((|x|)) form radian to degree
=end
def Extmath.rad2deg(x)
  return @@Rad2deg * x
end

=begin
--- Extmath.rad2gon(x)
    Converts ((|x|)) form radian to gon
=end
def Extmath.rad2gon(x)
  return @@Rad2gon * x
end

=begin
--- Extmath.root(x, y)
    ((|y|))-th root of ((|x|))
=end
def Extmath.root(x, y)
  x ** (1.0 / y)
end

=begin
--- Extmath.round(x)
    ((|x|)) rounded to nearest integer
=end
def Extmath.round(x)
  x.round
end

=begin
--- Extmath.sec(x)
    Secans of ((|x|))
=end
def Extmath.sec(x)
  1.0 / Math.cos(x)
end

=begin
--- Extmath.sech(x)
    Secans hyperbolicus of ((|x|))
=end
def Extmath.sech(x)
  1.0 / Math.cosh(x)
end

=begin
--- Extmath.sign(x)
    Sign of ((|x|)) - -1 for negative ((|x|)), +1 for positive ((|x|)) and zero for ((|x|)) = 0 
=end
def Extmath.sign(x)
  (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : 0.0)
end

=begin
--- Extmath.sin(x)
    Same as (({Math.sin(((|x|)))})) - sinus of ((|x|))
=end
def Extmath.sin(x)
  Math.sin(x)
end

=begin
--- Extmath.sinc(x)
    Sinc function of ((|x|))
=end
def Extmath.sinc(x)
  (x == 0.0) ? 1.0 : Math.sin(x) / x
end

=begin
--- Extmath.sinh(x)
    Same as (({Math.sinh(x)})) - sinus hyperbolicus of ((|x|))
=end
def Extmath.sinh(x)
  Math.sinh(x)
end

=begin
--- Extmath.sqr(x)
    Square of ((|x|))
=end
def Extmath.sqr(x)
  x * x
end

=begin
--- Extmath.sqrt(x)
    Square root of ((|x|))
=end
def Extmath.sqrt(x)
  Math.sqrt(x)
end

=begin
--- Extmath.sqsolve(a, b, c, d)
    Returns array of real solution of (({((|a|))x**2 + ((|b|))x + ((|c|)) = ((|d|))})) or (({nil})) if no or an infinite number of
    solutions exist. If (({d})) is missing it is assumed to be 0. See ((<Solving second order equations>))
=end
def Extmath.sqsolve(a, b, c, d = 0.0)
  if a == 0.0
    x = linsolve(b, c, d)
    return x.nil? ? nil: [ linsolve(b, c, d) ]
  else
    return [0.0, linsolve(a, b)].sort if c == d
    if b == 0.0
      x = Extmath.linsolve(a, c, d)
      x < 0.0 ? nil : [-Math.sqrt(x), Math.sqrt(x)]
    else
      x = b * b + 4.0 * a * (d - c)
      return nil if x < 0.0
      x = b < 0 ? b - Math.sqrt(x) : b + Math.sqrt(x)
      [-0.5 * x / a, 2.0 * (d - c) / x].sort
    end
  end
end

=begin
--- Extmath.tan(x)
    tangens of ((|x|))
=end
def Extmath.tan(x)
  Math.tan(x)
end

=begin
--- Extmath.tanh(x)
    tangens hyperbolicus of ((|x|))
=end
def Extmath.tanh(x)
  Math.tanh(x)
end

=begin
--- Extmath.tgamma(x)
    Gamma function of ((|x|))
=end
def Extmath.tgamma(x)
  Extmath.exp(Extmath.lgamma(x))
end

end

=begin
== Solving second order equations
In order to solve ((*ax**2 + bx + c = d*)) ((<Extmath.sqsolve>)) identifies several cases:
: ((*a == 0:*))
  The equation to be solved is the linear equation ((*bx + c = d*)). ((<Extmath.sqsolve>)) delegates the computation to
  ((<Extmath.linsolve>)). If it results in (({nil})), (({nil})) is returned (not (({[nil]}))!). Otherwise a one-element array
  containing result of ((<Extmath.linsolve>)) is returned.
: ((*a != 0:*))
  The equation to be solved actually is a second order one.
  : ((*c == d*))
    The equation to be solved is ((*ax**2 + bx = 0*)). One solution of this equation obviously is ((*x = 0*)), the second one
    solves ((*ax + b = 0*)). The solution of the latter is delegated to ((<Extmath.linsolve>)). An array containing both results in
    ascending order is returned.
  : ((*c != d*))
    The equation cannot be separated into ((*x*)) times some factor.
    : ((*b == 0*))
      The equation to be solved is ((*ax**2 + c = d*)). This can be written as the linear equation ((*ay + c = d*)) with
      ((*y = x ** 2*)). The solution of the linear equation is delegated to ((<Extmath.linsolve>)). If the returned value for
      ((*y*)) is (({nil})), that becomes the overall return value. Otherwise an array containing the negative and positive square
      root of ((*y*)) is returned
    : ((*b != 0 *))
      The equation cannot be reduced to simpler cases. We now first have to compute what is called the discriminant
      ((*x = b**2 + 4a(d - c)*)) (that's what we need to compute the square root of). If the descriminant is negative no real
      solution exists and (({nil})) is returned. The ternary operator checking whether ((*b*)) is negative does ensure better
      numerical stability - only one of the two solutions is computed using the widely know formula for solving second order
      equations. The second one is computed from the fact that the product of both solutions is ((*(c - d) / a*)). Take a look at a
      book on numerical mathematics if you don't understand why this should be done.
== Changelog
=== Version 2.2 -> 2.3
==== Renamed Constants/Functions
* ((<ExtMath.pwr|Extmath.pow>)) became ((<Extmath.pow>)) because (({pow})) is the C name for this function.
* ((<ExtMath.ln_gamma|Extmath.lgamma>)) became ((<Extmath.lgamma>)) because (({lgamma})) is the C name for this function.
* ((<ExtMath.gamma|Extmath.tgamma>)) became ((<Extmath.tgamma>)) because (({tgamma})) is the C name for this function.
==== New Constants/Functions
* ((<Extmath.deg2gon>)) (degree to gon)
* ((<Extmath.deg2rad>)) (degree to gon)
* ((<Extmath.gon2deg>)) (gon to degree)
* ((<Extmath.gon2rad>)) (gon to radian)
* ((<Extmath.rad2deg>)) (radian to degree)
* ((<Extmath.rad2gon>)) (radian to gon)
=== Version 2.1 -> 2.2
==== Renamed Constants/Functions
* ((<Extmath.acosech|Extmath.acsch>)) became ((<Extmath.acsch>))
* ((<Extmath.cosec|Extmath.csc>)) became ((<Extmath.csc>))
* ((<Extmath.cosech|Extmath.csch>)) became ((<Extmath.csch>))
==== New Constants/Functions
* ((<Extmath.acsc>))
* ((<Extmath.asec>))
* ((<Extmath.linsolve>))
* ((<Extmath.round>))
* ((<Extmath.sqsolve>))
* ((<Extmath::C>)) (Euler's constant ((*C*)))
==== Changed Implementations/Values
* ((<Extmath.abs>))
* ((<Extmath.ceil>))
* ((<Extmath.floor>))
==== Misc Changes
* README accidentally was that of
  ((<tldlib|URL:http://tldlib.rubyforge.org/>)). Corrected.
* Embedded documentation did contain old name (({ExtMath})), not (({Extmath})) - 'm' and 'M' almost look the same in the font I
  use. Corrected.
* Numerical constants were grouped using underbars to enhance readability.
* Changelog was cleaned up, hyperlinks were added to HTML version.
* Much work was put into documentation.
=== Version 2.0 -> 2.1
==== New constants/functions
* ((<Extmath.acosech|Extmath.csch>))
* ((<Extmath.asech>))
* ((<Extmath.delta>))
* ((<Extmath.epsilon>))
==== Misc Changes
* New embedded documentation was written using ((<RDtool|URL:http://www2.pos.to/~tosh/ruby/rdtool/en/index.html>))
* Online documentation of library is now generated from embedded documentation.
* HTML documentation contained in zip file has been replaced by plain text equivalent generated by Elinks which is available at
  ((<elinks.or.cz|URL:http://elinks.or.cz/>)).
=== Version 1.7 -> 2.0
==== Removed Constants/Functions
* (({Extmath.binomial}))
* (({Extmath.gaussian}))
* (({Extmath.sqsolve}))
==== Renamed Constants/Functions
* ((<ExtMath.lngamma|Extmath.lgamma>)) became ((<Extmath.ln_gamma|Extmath.lgamma>))
==== Misc Changes
* Homepage was moved to ((<extmath.rubyforge.org|URL:http://extmath.rubyforge.org/>))
* Download page was moved to ((<Rubyforge|URL:http://rubyforge.org/projects/extmath/>))
* Library now assumes Ruby 1.8
* Library was renamed from (({ExtMath})) to (({Extmath}))
* Embedded documentation was removed.
* HTML documentation was added to zip file.
* Demonstration program was replaced by test unit.
=== Version 1.6 -> 1.7
==== Changed implementations
* ((*Bugfix:*)) Value of (({@@InvLn2})) was (({Math.log(2.0)})), corrected to (({1.0 / Math.log(2.0)})). Thanks to Joseph McDonald.
=== Version 1.5 -> 1.6
==== Misc Changes
* Documentation now uses RDTool
* Changelog now generated uses RDTool
=== Version 1.4 -> 1.5
==== New Constants/Functions
* ((<ExtMath.gcd|Extmath.gcd>))
* ((<ExtMath.lcm|Extmath.lcm>))
=== Version 1.3 -> 1.4
=== New Constants/Functions
* (({ExtMath.binomial}))
* (({ExtMath.gaussian}))
* (({ExtMath.sqsolve}))
==== Changed Implementations/Values
* ((<ExtMath.log2|Extmath.log2>))
* ((<ExtMath.factorial|Extmath.factorial>))
=== Version 1.2 -> 1.3
==== New Constants/Functions
* ((<ExtMath.beta|Extmath.beta>))
* ((<ExtMath.ceil|Extmath.ceil>))
* ((<ExtMath.factorial|Extmath.factorial>))
* ((<ExtMath.floor|Extmath.floor>))
==== Changed Implementations/Values
* ((<Extmath.lngamma|Extmath.lgamma>))
* ((<ExtMath.gamma|Extmath.tgamma>))
=== Version 1.1 -> 1.2
==== New Constants/Functions
* ((<ExtMath.abs|Extmath.abs>))
* ((<ExtMath.gamma|Extmath.tgamma>))
* ((<ExtMath.lngamma|Extmath.lgamma>))
* ((<ExtMath.sign|Extmath.sign>))
* ((<ExtMath.sinc|Extmath.sinc>))
=== Version 1.0 -> 1.1
==== New Constants/Functions
* ((<ExtMath.cosec|Extmath.csc>))
* ((<ExtMath.cosech|Extmath.csch>))
* ((<ExtMath.sec|Extmath.sec>))
* ((<ExtMath.sech|Extmath.sech>))
==== Misc Changes
* Demonstration now also uses ((<ExtMath.cosec|Extmath.csc>)), ((<ExtMath.cosech|Extmath.csch>)), ((<ExtMath.sec|Extmath.sec>)),
  and ((<ExtMath.sech|Extmath.sech>)).
* Small changes of Rubydoc documentation.
=== Version 1.0
* First public release
=end
