module Enumerable

  # A more versitle #compact method. It can be used to
  # collect and filter items out in one single step.
  #
  #   c = [1,2,3].compact_map do |n|
  #     n < 2 ? nil : n
  #   end
  #
  #   c  #=> [2,3]
  #
  # CREDIT: Trans
  #
  # DEPRECATE: This method should probably be removed b/c #purge
  # does almost the same thing and enum.map{}.compact works too.

  def compact_map(&block)
    warn "Enumerable#compact_map is deprecated. Use Enumerable#filter_map instead.", uplevel: 1
    filter_map(&block)
  end

  #
  alias_method :compact_collect, :compact_map

end

