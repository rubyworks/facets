module Math

  # Greatest common divisor of +m+ and +n+, +nil+ for non-positive
  # numbers - gcd is computed by means of the Euclidian algorithm.
  def self.gcd(m, n)
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

end
