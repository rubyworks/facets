module Enumerable

  # Expand all elements of an Enumerable object.
  #
  #   [0, 2..3, 5..7].expand  #=> [0,[2, 3],[5,6,7]]
  #
  # CREDIT: Trans
  def expand
    map do |x|
     (Enumerable === x ? x.expand : x)
    end
  end

end

