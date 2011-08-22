class Time

  #
  def past?(other=nil)
    self < (other || ::Time.now)
  end

  #
  def future?(other=nil)
    self > (other || ::Time.now)
  end

end

