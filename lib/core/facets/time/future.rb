class Time

  def self.current
    now
  end

  def past?(other=nil)
    self < (other || self.class.current)
  end

  def future?(other=nil)
    self > (other || self.class.current)
  end

end

