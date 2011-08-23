class Time

  # Truncate time at give range (in seconds).
  #
  #   t = Time.now
  #   t = t.trunc(60*60)
  #   t.min #=> 0
  #   t.sec #=> 0
  #
  def trunc(amount)
    self - (self.to_i % amount)
  end

end

