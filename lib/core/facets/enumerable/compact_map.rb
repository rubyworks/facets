module Enumerable

  # A more versitle #compact method. It can be used to
  # collect and filter items out in one single step.
  #
  #   (1..3).compact_map do |n|
  #     n < 1 ? nil : n
  #   end
  #
  # _produces_
  #
  #   [2,3]
  #
  # CREDIT: Trans

  def compact_map(trash=nil, &block)
    y = []
    if block_given?
      each do |*a|
        r = yield(*a)
        y << r unless trash == r
      end
    else
      each do |r|
        y << r unless trash == r
      end
    end
    y
  end

end

