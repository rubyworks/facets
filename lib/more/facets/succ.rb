class Integer

  # Allows #succ to take _n_ increments.
  #
  #   3.succ(2)  #=> 5
  #
  #   CREDIT Trans

  def succ(n=1)
    self + n
  end

  # Provides #pred as the opposite of #succ.
  #
  #   3.pred(2)  #=> 1
  #
  #   CREDIT Trans

  def pred(n=1)
    self - n
  end

end

class String

  alias_method :succ1, :succ

  # Allows #succ to take _n_ step increments.
  #
  #   "abc".succ      #=> "abd"
  #   "abc".succ(4)   #=> "abg"
  #   "abc".succ(24)  #=> "aca"
  #
  #  CREDIT Trans

  def succ(n=1)
    s = self
    n.times { s = s.succ1 }
    s
  end

end

