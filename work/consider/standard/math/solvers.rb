module Math #:nodoc:

  # = Solver Math Extensions
  #
  module Solvers

    # Returns real solution(s) of <code>+a+x + +b+ = +c+</code> or +nil+
    # if no or an infinite number of solutions exist. If
    # <code>c</code> is missing it is assumed to be 0.
    def linsolve(a, b, c = 0.0)
      a == 0 ? nil : (c - b) / a
    end

    # Returns array of real solution of <code>ax**2 + bx + c = d</code>
    # or <code>nil</code> if no or an infinite number of solutions exist.
    # If +d+ is missing it is assumed to be 0.
    #
    # == Solving second order equations
    # In order to solve <code>ax**2 + bx + c = d</code> +Extmath.sqsolve+ identifies several cases:
    # * <code>a == 0:</code>
    #   The equation to be solved is the linear equation <code>bx + c = d</code>. #sqsolve> delegates the computation to
    #   #linsolve>. If it results in +nil+, +nil+ is returned (not <code>[nil]</code>!). Otherwise a one-element array
    #   containing result of #linsolve is returned.
    # * <code>a != 0:</code>
    #    The equation to be solved actually is a second order one.
    #    * <code>c == d</code>
    #      The equation to be solved is <code>ax**2 + bx = 0</code>. One solution of this equation obviously is
    #      <code>x = 0</code>, the second one solves <code>ax + b = 0</code>. The solution of the latter is
    #      delegated to +Extmath.linsolve+. An array containing both results in ascending order is returned.
    #    * <code>c != d</code>
    #      The equation cannot be separated into <code>x</code> times some factor.
    #      * <code>b == 0</code>
    #        The equation to be solved is <code>ax**2 + c = d</code>. This can be written as the linear equation
    #        <code>ay + c = d</code> with <code>y = x ** 2</code>. The solution of the linear equation is delegated
    #        to +Extmath.linsolve+. If the returned value for +y+ is +nil+, that becomes the overall return value.
    #        Otherwise an array containing the negative and positive squareroot of +y+ is returned
    #      * <code>b != 0 </code>
    #        The equation cannot be reduced to simpler cases. We now first have to compute what is called the
    #        discriminant <code>x = b**2 + 4a(d - c)</code> (that's what we need to compute the square root of).
    #        If the descriminant is negative no real solution exists and <code>nil</code> is returned. The ternary
    #        operator checking whether <code>b</code> is negative does ensure better numerical stability --only one
    #        of the two solutions is computed using the widely know formula for solving second order equations.
    #        The second one is computed from the fact that the product of both solutions is <code>(c - d) / a</code>.
    #        Take a look at a book on numerical mathematics if you don't understand why this should be done.
    #
    def sqsolve(a, b, c, d = 0.0)
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

  end

  include Solvers
  extend  Solvers
end
