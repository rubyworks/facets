module Enumerable

  # Same as #collect but with an iteration counter.
  #
  #   a = [1,2,3].collect_with_index { |e,i| e*i }
  #   a  #=> [0,2,6]
  #
  # CREDIT: Gavin Sinclair

  def map_with_index
    r = []
    each_with_index do |e, i|
      r << yield(e, i)
    end
    r
  end

  # Alias for map_with_index.

  alias_method :collect_with_index, :map_with_index

end

