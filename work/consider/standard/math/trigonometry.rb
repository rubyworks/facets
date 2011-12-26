module Math #:nodoc:

  # Trigonometric functions.
  #
  # * Trigonometric functions
  #   +acos+, +acot+, +acsc+, +asec+, +asin+, +atan+, +atan2+, +cos+, +cot+, +csc+, +sec+, +sin+, +tan+
  #
  # * Hyperbolic functions
  #   +acosh+, +acoth+, +acsch+, +asech+, +asinh+, +atanh+, +cosh+, +coth+, +csch+, +sech+, +sinh+, +tanh+
  #
  # * Conversion between degree, gon and radian
  #   +deg2gon+, +deg2rad+, +gon2deg+, +gon2rad+, +rad2deg+, +rad2gon+
  #
  module Trigonometry
    
    # Same as <code>Math::PI</code>
    # Ludolph's number, <code>PI = 3.141_59..</code>.
    PI = ::Math::PI

    PI_BY_2 = 0.5 * PI

    DEG_TO_GON = 10.0 / 9.0
    DEG_TO_RAD = PI / 180.0
    GON_TO_DEG = 0.9
    GON_TO_RAD = PI / 200.0
    RAD_TO_DEG = 180.0 / PI
    RAD_TO_GON = 200.0 / PI

    # Sine of x.
    def sin(x)
      ::Math.sin(x)
    end

    # Hyperbolic Sine of +x+.
    def sinh(x)
      ::Math.sinh(x)
    end

    # Sinc function of +x+.
    def sinc(x)
      (x == 0.0) ? 1.0 : sin(x) / x
    end

    # Tagent of +x+.
    def tan(x)
      ::Math.tan(x)
    end

    # Hyperbolic tagent of +x+.
    def tanh(x)
      ::Math.tanh(x)
    end

    # Arcus tangens of +x+.
    def atan(x)
      ::Math.atan(x)
    end

    # Arcus tangens of +x+ over +y+.
    def atan2(x, y)
      ::Math.atan2(x, y)
    end

    # Same as <code>Math.atanh(+x+)</code> - area tangens hyperbolicus of +x+
    def atanh(x)
      ::Math.atanh(x)
    end

    # Same as <code>Math.cos(+x+)</code> - cosinus of +x+
    def cos(x)
      ::Math.cos(x)
    end

    # Same as <code>Math.cosh(+x+)</code> - cosinus hyperbolicus of +x+
    def cosh(x)
      ::Math.cosh(x)
    end

    # Same as <code>Math.acos(+x+)</code> - arcus cotangens of +x+
    def acos(x)
      ::Math.acos(x)
    end

    # Same as <code>Math.acosh(+x+)</code> - area cosinus hyperbolicus of +x+
    def acosh(x)
      ::Math.acosh(x)
    end

    # Arcus cotangens of +x+
    def acot(x)
      PI_BY_2 - atan(x)
    end

    # Area cotangens hyperbolicus of +x+
    def acoth(x)
      0.5 * ::Math.log((x + 1.0) / (x - 1.0))
    end

    # Arcus cosecans of +x+
    def acsc(x)
      asin(1.0 / x)
    end

    # Area cosecans hyperbolicus of +x+
    def acsch(x)
      ::Math.log(1.0 / x + Math.sqrt(1.0 + 1.0 / (x * x)))
    end

    # Arcus secans of +x+
    def asec(x)
      acos(1.0 / x)
    end

    # Area secans hyperbolicus of +x+
    def asech(x)
      ::Math.log((1.0 + ::Math.sqrt(1.0 - x * x)) / x)
    end

    # Same as <code>Math.asin(+x+)</code> - arcus sinus of +x+
    def asin(x)
      ::Math.asin(x)
    end

    # Same as <code>Math.sinh(+x+)</code> - area sinus hyperbolicus of +x+
    def asinh(x)
      ::Math.asinh(x)
    end

    # Cotangens of +x+
    def cot(x)
      tan(PI_BY_2 - x)
    end

    # Cotangens hyperbolicus of +x+
    def coth(x)
      1.0 / tanh(x)
    end

    # Cosecans of +x+
    def csc(x)
      1.0 / sin(x)
    end

    # Cosecans hyperbolicus of +x+
    def csch(x)
      1.0 / sinh(x)
    end

    # Secans of +x+.
    def sec(x)
      1.0 / cos(x)
    end

    # Secans hyperbolicus of +x+
    def sech(x)
      1.0 / cosh(x)
    end

    # Converts +x+ form degree to gon
    def deg2gon(x)
      return DEG_TO_GON * x
    end

    # Converts +x+ form degree to radian
    def deg2rad(x)
      return DEG_TO_RAD * x
    end

    # Converts +x+ form gon to degree
    def gon2deg(x)
      return GON_TO_DEG * x
    end

    # Converts +x+ form gon to radian
    def gon2rad(x)
      return GON_TO_RAD * x
    end

    # Same as <code>Math.hypot(+x+, +y+)</code>, length of hypotenuse of a rectangular triangle with sides +x+ and +y+.
    def hypot(x, y)
      ::Math.hypot(x, y)
    end

  end

  include Trigonometry
  extend  Trigonometry
end

