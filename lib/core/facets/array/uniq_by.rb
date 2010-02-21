require 'facets/enumerable/uniq_by'

class Array

  # Like #uniq, but determines uniqueness based on a given block.
  #
  #   (-5..5).to_a.uniq_by {|i| i*i }
  #
  # produces
  #
  #   [-5, -4, -3, -2, -1, 0]
  #
  def uniq_by! #:yield:
    h = {}; replace(inject([]){|a,x| h[yield(x)] ||= a << x})
  end

end

