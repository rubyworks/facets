class Time

  # Truncate time at give range (in seconds).
  #
  #   t = Time.now
  #   =>
  #   t.trunc(60*60) # 1 hour
  #   =>
  #
  def trunc(amount)
    self - (self.to_i % amount)
  end

end

