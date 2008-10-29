module Enumerable

  # Like #uniq, but determines uniqueness based on a given block.
  #
  #   (-5..5).to_a.uniq_by {|i| i*i }
  #
  # produces
  #
  #   [-5, -4, -3, -2, -1, 0]
  #
  #   CREDIT: ?

  def uniq_by #:yield:
    h = {}; inject([]) {|a,x| h[yield(x)] ||= a << x}
  end

end

