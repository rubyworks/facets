module Math

  # Least common multiple of +m+ and +n+, computed by multiplying
  # +m+ and +n+ and dividing the product by the gcd of +m+ and +n+,
  # +nil+ for non-positive numbers.
  def self.lcm(m, n)
    m = Integer(m)
    n = Integer(n)
    if m <= 0 || n <= 0
      return nil
    end
    m / gcd(m, n) * n
  end

end
