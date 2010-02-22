class Time

  #
  def past?
    self < ::Time.current
  end

  #
  def future?
    self < ::Time.current
  end

end

