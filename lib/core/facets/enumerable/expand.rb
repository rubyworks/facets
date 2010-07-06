module Enumerable

  # Expand all elements of an Enumerable object.
  #
  # CREDIT: Trans
  def expand
    map do |x|
     (Enumerable === x ? x.expand : x)
    end
  end

end

