require 'facets/time/trunc'

class Time

  # Round time at the nearest range (in seconds).
  #
  #   t1 = Time.now
  #   t2 = t1.round_to(60*60)
  #   t2.min #=> 0
  #   t2.sec #=> 0
  #
  # TODO: What about `round(:minute)`?
  #
  # TODO: Fractional seconds should round the usec.
  #
  def round_to(seconds)
    (self + seconds / 2.0).trunc(seconds)
  end

end

