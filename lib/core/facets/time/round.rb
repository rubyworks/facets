require 'facets/time/trunc'

class Time

  # Round time at the nearest range (in seconds).
  #
  #   t = Time.now
  #   =>
  #   t.round(60*60) # 1 hour
  #   =>
  #  
  def round(amount)
    (self+amount/2.0).trunc(amount)
  end

end

