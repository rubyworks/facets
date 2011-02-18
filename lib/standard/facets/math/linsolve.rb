module Math

  # Returns real solution(s) of <code>+a+x + +b+ = +c+</code> or +nil+
  # if no or an infinite number of solutions exist. If
  # <code>c</code> is missing it is assumed to be 0.
  def self.linsolve(a, b, c = 0.0)
    a == 0 ? nil : (c - b) / a
  end

end
