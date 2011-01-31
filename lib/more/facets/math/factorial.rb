module Math

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

  # 1 * 2 * ... * +n+, <code>nil</code> for negative numbers
  def self.factorial(n)
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

end
