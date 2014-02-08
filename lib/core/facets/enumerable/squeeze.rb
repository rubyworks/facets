module Enumerable

  # Squeezes the same element. This behaves like C++ unique().
  # To get the similar result to Array#uniq, you need to sort it prior.
  #
  #   [1,2,2,3,3,2,1].squeeze #=> [1,2,3,2,1]
  #   [1,2,2,3,3,2,1].sort.squeeze #=> [1,2,3]
  #
  # Calculation order is O(n).
  #
  # CREDIT: T. Yamada

  def squeeze
    r=[]
    cur=nil
    self.each{|e|
      if r.empty?||cur!=e
        r<<e
        cur=e
      end
    }
    r
  end

end

