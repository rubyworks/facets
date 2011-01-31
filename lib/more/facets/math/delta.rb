module Math

  # Kronecker symbol of +i+ and +j+ - 1 if +i+ and +j+ are equal, 0 otherwise.
  def self.delta(i, j)
    return Integer(i) == Integer(j) ? 1 : 0
  end

end
