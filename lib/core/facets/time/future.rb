class Time

  # The current time. That's Time.now, unless ActiveSupport's Time.zone is
  # set, in which case it's the current time in that zone, as in
  # ActiveSupport's own Time.current. So the two agree whichever is loaded.
  def self.current
    respond_to?(:zone) && zone ? zone.now : now
  end

  # Is this time before +other+, or before now if not given?
  def past?(other=nil)
    self < (other || self.class.current)
  end

  # Is this time after +other+, or after now if not given?
  def future?(other=nil)
    self > (other || self.class.current)
  end

end
