module Kernel

  # Alternate to standard #p method that outputs
  # Kernel#inspect to stdout, but also passes through
  # the orginal argument(s).
  #
  #   x = 1
  #   r = 4 + q(1)
  #   p r
  #
  # produces
  #
  #   1
  #   5
  #
  # DEPRECATE AS OF 1.9, _if_ #p will then do this too.

  def p(*x)
    x.each{ |e| puts e.inspect } #p(*x)
    x.size > 1 ? x : x.last #x.last
  end

end

