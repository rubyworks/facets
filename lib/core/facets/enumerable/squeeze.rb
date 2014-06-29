module Enumerable

  # Squeeze out the same elements. This behaves like C++ unique(),
  # removing equivalent elements that are concomitant to each other.
  # To get a similar result with Array#uniq, the array would have to
  # be sorted first.
  #
  # Calculation order is O(n).
  #
  # Examples
  #
  #   [1,2,2,3,3,2,1].squeeze #=> [1,2,3,2,1]
  #   [1,2,2,3,3,2,1].sort.squeeze #=> [1,2,3]
  #   [1,2,2,3,3,2,1].squeeze(*[3]) #=> [1,2,2,3,2,1]
  #
  # Returns [Array].
  #
  # CREDIT: T. Yamada

  def squeeze(*limited_to)
    first = true
    r = []   # result
    c = nil  # current
    each do |e|
      if !limited_to.empty? && !limited_to.include?(e)
        r << e
      elsif first || c != e
        r << e
        first = false
        c = e
      end
    end
    r
  end

end
