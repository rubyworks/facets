module Math

  # Levi-Civita symbol of +i+, +j+, and +k+ - 1 if (+i+, +j+, +k+)
  # is (1, 2, 3), (2, 3, 1), or (3, 1, 2), -1 if it is (1, 3, 2),
  # (2, 1, 3), or (3, 2, 1), 0 as long as +i+, +j+, and +k+ are
  # all elements of {1, 2, 3}, otherwise returns <code>nil</code>.
  def self.epsilon(i, j, k)
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

end
