module Enumerable

  # A versitle compaction method. Like #map but used
  # to filter out multiple items in a single step.
  #
  # Without +trash+ arguments +nil+ is assumed.
  #
  #   [1, nil, 2].purge  #=> [1,2]
  #
  # If +trash+ arguments are given, each argument is
  # compared for a match using #==.
  #
  #   (1..6).purge(3,4)  #=> [1,2,5,6]
  #
  # If a block is given, the yield is used in the
  # matching condition instead of the element itsef.
  # 
  #   (1..6).purge(0){ |n| n % 2 }  #=> [1,3,5]
  #
  # NOTE: This could just as well be an override of the
  # core #compact method, but to avoid potential issues
  # associated with overriding core methods we use the
  # alternate name #purge.
  #
  # CREDIT: Trans

  def purge(*trash, &block)
    trash = [nil] if trash.empty?
    r = []
    if block_given?
      each do |e|
        y = yield(e)
        r << e unless trash.any?{|t| t == y}
      end
    else
      each do |e|
        r << e unless trash.any?{|t| t == e}
      end
    end
    r
  end

end
