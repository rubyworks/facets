#
# @author Matthew Harris
#
class Duration
  include Comparable

  SECOND =   1
  MINUTE =  60 * SECOND
  HOUR   =  60 * MINUTE
  DAY    =  24 * HOUR
  WEEK   =   7 * DAY
  YEAR   = 365 * DAY

  SEGMENTS = %w{years weeks days hours minutes seconds}.collect{ |s| s.to_sym }

  #
  def self.[](seconds, *segments)
    new(seconds, *segments)
  end

  #
  def initialize(seconds=0, *segments)
    @seconds = seconds.to_i
    reset_segments(*segments)
  end

  #
  def segments; @segments; end

  #
  def reset_segments(*segments)
    case segments.size
    when 0
      @segments = [:days, :hours, :minutes, :seconds]
    when 1
      case segments = segments[0]
      when Array
        @segments = segments.collect{ |p| (p.to_s.downcase.chomp('s') + 's').to_sym }
        raise ArgumentError unless @segments.all?{ |s| SEGMENTS.include?(s) }
      else
        f = SEGMENTS.index(segments)
        @segments = SEGMENTS[f..0]
      end
    when 2
      f = SEGMENTS.index(segments[0])
      t = SEGMENTS.index(segments[1])
      @segments = SEGMENTS[f..t]
    else
      raise ArgumentError
    end
  end

  def inspect
    h = to_h
    segments.reverse.collect do |l|
      "#{h[l.to_sym]} #{l}"
    end.join(' ')
  end

  def to_i ; @seconds.to_i ; end
  def to_f ; @seconds.to_f ; end

  public

  def to_a
    a, s = [], @seconds
    a[5], s = *s.divmod(YEAR)   if @segments.include?(:years)
    a[4], s = *s.divmod(WEEK)   if @segments.include?(:weeks)
    a[3], s = *s.divmod(DAY)    if @segments.include?(:days)
    a[2], s = *s.divmod(HOUR)   if @segments.include?(:hours)
    a[1], s = *s.divmod(MINUTE) if @segments.include?(:minutes)
    a[0], s = *s.divmod(SECOND) if @segments.include?(:seconds)
    a.compact.reverse
  end

  #
  def to_h
    h, s = {}, @seconds
    h[:years],   s = *s.divmod(YEAR)   if @segments.include?(:years)
    h[:weeks],   s = *s.divmod(WEEK)   if @segments.include?(:weeks)
    h[:days],    s = *s.divmod(DAY)    if @segments.include?(:days)
    h[:hours],   s = *s.divmod(HOUR)   if @segments.include?(:hours)
    h[:minutes], s = *s.divmod(MINUTE) if @segments.include?(:minutes)
    h[:seconds], s = *s.divmod(SECOND) if @segments.include?(:seconds)
    h
  end

  def to_s
    h = to_h
    segments.reverse.collect do |l|
      "#{h[l.to_sym]} #{l}"
    end.join(' ')
  end

  # Returns true if <tt>other</tt> is also a Duration instance with the
  # same <tt>value</tt>, or if <tt>other == value</tt>.
  def ==(other)
    if Duration === other
      other.seconds == seconds
    else
      other == seconds
    end
  end

  def <=>(other)
    @seconds <=> other.to_i
  end

  #def is_a?(klass) #:nodoc:
  #  klass == self.class
  #end

  #def self.===(other) #:nodoc:
  #  other.is_a?(Duration) rescue super
  #end

  def years   ; to_h[:years]   ; end
  def weeks   ; to_h[:weeks]   ; end
  def days    ; to_h[:days]    ; end
  def hours   ; to_h[:hours]   ; end
  def minutes ; to_h[:minutes] ; end
  def seconds ; to_h[:seconds] ; end

  def total ; seconds ; end

  def +(other)
    self.class.new(@seconds + other.to_i, segments)
  end

  def -(other)
    self.class.new(@seconds - other.to_i, segments)
  end

  def *(other)
    self.class.new(@seconds * other.to_i, segments)
  end

  def /(other)
    self.class.new(@seconds / other.to_i, segments)
  end

  #
  def segmented(*segments)
    self.class.new(@seconds, segments)
    #segments = segments.collect{ |p| p.to_s.downcase.chomp('s') }
    #y,w,d,h,m,s = nil,nil,nil,nil,nil,nil
    #x = @seconds
    #y, x = *x.divmod(YEAR)   if segments.include?('year')
    #w, x = *x.divmod(WEEK)   if segments.include?('week')
    #d, x = *x.divmod(DAY)    if segments.include?('day')
    #h, x = *x.divmod(HOUR)   if segments.include?('hour')
    #m, x = *x.divmod(MINUTE) if segments.include?('minute')
    #s = x if segments.include?('second')
    #[y, w, d, h, m, s].compact
  end

  # Format duration.
  #
  # *Identifiers*
  #
  #     %w -- Number of weeks
  #     %d -- Number of days
  #     %h -- Number of hours
  #     %m -- Number of minutes
  #     %s -- Number of seconds
  #     %t -- Total number of seconds
  #     %x -- Duration#to_s
  #     %% -- Literal `%' character
  #
  # *Example*
  #
  #     d = Duration.new(:weeks => 10, :days => 7)
  #     => #<Duration: 11 weeks>
  #     d.strftime("It's been %w weeks!")
  #     => "It's been 11 weeks!"
  #
  def strftime(fmt)
    h = to_h
    hx = {
     'y' => h[:years]  ,
     'w' => h[:weeks]  ,
     'd' => h[:days]   ,
     'h' => h[:hours]  ,
     'm' => h[:minutes],
     's' => h[:seconds],
     't' => total,
     'x' => to_s 
    }
    fmt.gsub(/%?%(w|d|h|m|s|t|x)/) do |match|
      hx[match[1..1]]
    end.gsub('%%', '%')
  end

  #
  def -@ #:nodoc:
    self.class.new(-@seconds)
  end

  #
  def +@ #:nodoc:
    self.class.new(+@seconds)
  end

  #
  # Need to wrap back to numeric methods, maybe use method_missing?
  #

  #
  def before(time)
    @seconds.before(time)
  end

  #
  def after(time)
    @seconds.after(time)
  end


  # = Numeric Extensions for Durations
  #
  module Numeric

    # Enables the use of time calculations and declarations,
    # like 45.minutes + 2.hours + 4.years. The base unit for
    # all of these Numeric time methods is seconds.
    def seconds ; Duration[self] ; end
    alias_method :second, :seconds

    # Converts minutes into seconds.
    def minutes ; Duration[self * 60] ; end
    alias_method :minute, :minutes

    # Converts hours into seconds.
    def hours ; Duration[self * 3600] ; end
    alias_method :hour, :hours
    #def as_hours ; self / 60.minutes ; end

    # Converts days into seconds.
    def days ; Duration[self * 86400] ; end
    alias_method :day, :days

    # Converts weeks into seconds.
    def weeks ; Duration[self * 604800] ; end
    alias_method :week, :weeks

    # Converts fortnights into seconds.
    # (A fortnight is 2 weeks)
    def fortnights ; Duration[self * 1209600] ; end
    alias_method :fortnight, :fortnights

    # Converts months into seconds.
    # WARNING: This is not exact as it assumes 30 days to a month.
    def months ; Duration[self * 30 * 86400] ; end
    alias_method :month, :months

    # Converts years into seconds.
    # WARNING: This is not exact as it assumes 365 days to a year.
    #          ie. It doesn not account for leap years.
    def years ; Duration[self * 365 * 86400, :years] ; end
    alias_method :year, :years

  end

  # Time#duration has been added to convert the UNIX timestamp into a Duration.
  # See Time#duration for an example.
  #
  module Time
    # Create a Duration object from the UNIX timestamp.
    #
    # *Example*
    #
    #   Time.now.duration
    #   => #<Duration: 1898 weeks, 6 days, 1 hour, 12 minutes and 1 second>
    #
    def duration
      Duration[to_i]
    end
  end

end

class Numeric #:nodoc:
  include Duration::Numeric
end

class Time #:nodoc:
  include Duration::Time
end

