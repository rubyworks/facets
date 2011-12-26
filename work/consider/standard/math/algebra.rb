module Math #:nodoc:

  # = Algebra, Arithmetic and Number Theory Math Extensions
  #
  # Special thanks to Josef 'Jupp' Schugt <jupp@rubyforge.org> for his 
  # earlier work on Extmath. A few extensions to the Math module were
  # derived from his work.
  #
  # TODO: Rename to Arthmetic or NumberTheory?
  module Algebra

    extend self

    #
    GAUSS_FACTOR = ::Math.sqrt(0.5 / Math::PI)

    # First 16 factorials.
    FACTORIALS = [
      1,
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

    # Euler's constant <code>C</code>, <code>C = 0.577_2...</code>
    C = 0.577_215_664_901_532_861

    # Same as <code>Math::E</code> - Euler's number, <code>E = 2.718_182_8...</code>
    E = ::Math::E

    # Absolute value of +x+.
    def abs(x)
      x.abs
    end

    # Smallest integer not smaller than +x+.
    def ceil(x)
      x.ceil
    end

    # Kronecker symbol of +i+ and +j+ - 1 if +i+ and +j+ are equal, 0 otherwise.
    def delta(i, j)
      return Integer(i) == Integer(j) ? 1 : 0
    end

    # Levi-Civita symbol of +i+, +j+, and +k+ - 1 if (+i+, +j+, +k+) is (1, 2, 3), (2, 3, 1), or (3, 1, 2),
    # -1 if it is (1, 3, 2), (2, 1, 3), or (3, 2, 1), 0 as long as +i+, +j+, and +k+ are all elements of {1, 2, 3},
    # otherwise returns <code>nil</code>.
    def epsilon(i, j, k)
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

    # Same as <code>Math.erf(+x+)</code> - Gauﬂian error integral up to +x+
    def erf(x)
      ::Math.erf(x)
    end

    # Same as <code>Math.erfc(+x+)</code> - complementary Gauﬂian error integral from +x+ on
    def erfc(x)
      ::Math.erfc(x)
    end

    # 1 * 2 * ... * +n+, <code>nil</code> for negative numbers
    def factorial(n)
      n = Integer(n)
      if n < 0
        nil
      elsif FACTORIALS.length > n
        FACTORIALS[n]
      else
        h = FACTORIALS.last
        (FACTORIALS.length .. n).each { |i| FACTORIALS.push h *= i }
        h
      end
    end

    # Largest integer not larger than +x+.
    def floor(x)
      x.floor
    end

    # Greatest common divisor of +m+ and +n+, +nil+ for non-positive
    # numbers - gcd is computed by means of the Euclidian algorithm.
    def gcd(m, n)
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

    # Least common multiple of +m+ and +n+ - computed by multiplying +m+ and +n+ and dividing the product by the gcd
    # of +m+ and +n+, <code>nil</code> for non-positive numbers.
    def lcm(m, n)
      m = Integer(m)
      n = Integer(n)
      if m <= 0 || n <= 0
        return nil
      end
      m / gcd(m, n) * n
    end

    # Sign of +x+.
    # Returns -1 for negative x, +1 for positive x and zero for x = 0 
    def sign(x)
      (x > 0.0) ? 1.0 : ((x < 0.0) ? -1.0 : 0.0)
    end

    ### Converts +x+ form radian to degree
    ##def rad2deg(x)
    ##  return Rad2deg * x
    ##end

    ### Converts +x+ form radian to gon.
    ##def rad2gon(x)
    ##  return Rad2gon * x
    ##end
  end

  include Algebra
  extend  Algebra
end
