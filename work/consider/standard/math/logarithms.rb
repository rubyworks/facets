module Math #:nodoc:

  # = Logarithmic Math Extensions
  #
  module Logarithms
    extend self

    INVERSE_LN_2 = 1.0 / ::Math.log(2.0)

    # Same as <code>Math.exp(+x+)</code> - e to the power +x+
    def exp(x)
      ::Math.exp(x)
    end

    # 10 to the power +x+
    def exp10(x)
      10.0 ** x
    end

    # 2 to the power +x+
    def exp2(x)
      2.0 ** x
    end

    # Same as <code>Math.frexp(+x+)</code> - two-element array containing the normalized fraction and exponent of +x+.
    def frexp(x)
      Math.frexp(x)
    end

    # +x+ times 2 to the power +y+
    def ldexp(x, y)
      Math.ldexp(x, y)
    end

    # Beta function of +x+ and +y+ - <code>beta(+x+, +y+) =
    # tgamma(+x+) * tgamma(+y+) / tgamma(+x+ + +y+)</code>
    def beta(x, y)
      exp(lgamma(x) + lgamma(y) - lgamma(x+y))
    end

    # Logarithmus naturalis of gamma function of +x+
    def lgamma(x)
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

    # Same as <code>Math.log(+x+)</code> - logarithmus naturalis of +x+
    def log(x)
      Math.log(x)
    end

    # Same as <code>Math.log10(+x+)</code> - logarithmus decimalis of +x+
    def log10(x)
      Math.log10(x)
    end

    # Logarithmus dualis of +x+
    def log2(x)
      Math.log(x) * INVERSE_LN_2
    end

    # +x+ to the power +y+
    def pow(x, y)
      x ** y
    end

    # The +y+ root of +x+.
    def root(x, y)
      x ** (1.0 / y)
    end

    # Square of number.
    def sqr(x)
      x * x
    end

    #
    def sqrt(x)
      ::Math.sqrt(x)
    end

    #
    def gamma(x)
      exp(lgamma(x))
    end

  end

  include Logarithmic
  extend  Logarithmic
end

