module Kernel

  # Alternate to standard #p method that outputs
  # Kernel#inspect to stdout, but also passes through
  # the orginal argument(s) ...
  #
  #   x = 1
  #   r = 4 + p(1)
  #   p r
  #
  # produces ...
  #
  #   1
  #   5
  #
  # TODO: DEPRECATE as of 1.9, _if_ it will do this.

  def p(*x)
    x.each{ |e| puts e.inspect } #p(*x)
    x.size > 1 ? x : x.last #x.last
  end

end

