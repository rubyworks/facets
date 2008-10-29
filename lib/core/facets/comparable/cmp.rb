module Comparable

  # Alternate name for comparison operator #<=>.
  #
  #   3.cmp(1)   #=>  1
  #   3.cmp(3)   #=>  0
  #   3.cmp(10)  #=> -1
  #
  # This fundamental compare method is used to keep
  # comparison compatible with <tt>#succ</tt>.
  #
  #   CREDIT Peter Vanbroekhoven

  def cmp(o)
    self<=>o
  end
end

class String 

  # Compare method that takes length into account.
  # Unlike #<=>, this is compatible with #succ.
  #
  #   "abc".cmp("abc")   #=>  0
  #   "abcd".cmp("abc")  #=>  1
  #   "abc".cmp("abcd")  #=> -1
  #   "xyz".cmp("abc")   #=>  1
  #
  #   CREDIT Peter Vanbroekhoven

  def cmp(other)
    return -1 if length < other.length
    return 1 if length > other.length
    self <=> other  # alphabetic compare
  end

end

