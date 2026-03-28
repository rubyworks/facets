class Time

  # Truncate time to a given interval in seconds.
  # Unlike Ruby's Time#floor which takes sub-second digit precision,
  # this takes an interval in seconds.
  #
  #   t = Time.now
  #   t = t.floor_to(60*60)
  #   t.min #=> 0
  #   t.sec #=> 0
  #
  def floor_to(seconds)
    self - (self.to_i % seconds)
  end

  # @deprecated Use Time#floor_to instead.
  def trunc(seconds)
    warn "Time#trunc is deprecated. Use Time#floor_to instead.", uplevel: 1
    floor_to(seconds)
  end

end
