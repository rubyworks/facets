module Enumerable

  # A more versitle #compact method. It can be used to
  # collect and filter items out in one single step.
  #
  #   [1,2,3].compact_map do |n|
  #     n < 1 ? nil : n
  #   end
  #
  # _produces_
  #
  #   [2,3]
  #
  # CREDIT: Trans
  #
  # DEPRECATE: This method should probably be removed b/c #purge
  # does almost the same thing and enum.map{}.compact works too.

  def compact_map(&block)
    y = []
    if block_given?
      each do |*a|
        r = yield(*a)
        y << r unless r.nil?
      end
    else
      each do |r|
        y << r unless r.nil?
      end
    end
    y
  end

  #
  alias_method :compact_collect, :compact_map

end

