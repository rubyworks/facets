require 'date'
require 'facets/time/stamp'

# = Date
#
# This new version of Date extension has been largely improved by
# porting some of the methods used by ActiveSupport. The old version
# already had much in common with the Active Support library, so it
# was decided to take it a step further in that direction for the
# sake of interoparability.
#
# Hopefully most of these methods will find there way into Ruby's
# own standard library eventually.
#
# The biggest difference with ActiveSupport is the lack of many
# of the "English-esque" methods, and that we use #stamp with
# Date::FORMAT, instead of #to_formmated_s with Date::DATE_FORMATS.
# We do not override the standard #to_s method like ActiveSupport does.

class Date

  FORMAT = {
    :short        => "%e %b",
    :long         => "%B %e, %Y",
    :db           => "%Y-%m-%d",
    :number       => "%Y%m%d",
    :rfc822       => "%e %b %Y",
    :default      => "%Y-%m-%d",
    nil           => "%Y-%m-%d"
  }

  # Returns a new Date representing the date 1 day ago (i.e. yesterday's date).
  def self.yesterday
    ::Date.today.yesterday
  end
  
  # Returns a new Date representing the date 1 day after today (i.e. tomorrow's date).
  def self.tomorrow
    ::Date.today.tomorrow
  end
  
  # Returns Time.zone.today when config.time_zone is set, otherwise just returns Date.today.
  def self.current
    ::Time.zone_default ? ::Time.zone.today : ::Date.today
  end

  # A method to keep Time, Date and DateTime instances interchangeable
  # on conversions. In this case, it simply returns +self+.
  def to_date
    self
  end if RUBY_VERSION < '1.9'

  # Converts a Date instance to a DateTime, where the time is set to the beginning of the day
  # and UTC offset is set to 0.
  #
  # ==== Example:
  #   date = Date.new(2007, 11, 10)  # => Sat, 10 Nov 2007
  #
  #   date.to_datetime               # => Sat, 10 Nov 2007 00:00:00 0000
  def to_datetime
    ::DateTime.civil(year, month, day, 0, 0, 0, 0)
  end if RUBY_VERSION < '1.9'

  # Converts a Date instance to a Time, where the time is set to the beginning of the day.
  # The timezone can be either :local or :utc (default :local).
  #
  #   date = Date.new(2007, 11, 10)  # => Sat, 10 Nov 2007
  #
  #   date.to_time                   # => Sat Nov 10 00:00:00 0800 2007
  #   date.to_time(:local)           # => Sat Nov 10 00:00:00 0800 2007
  #
  #   date.to_time(:utc)             # => Sat Nov 10 00:00:00 UTC 2007
  #
  def to_time(form=:local)
    ::Time.send(form, year, month, day)
    #::Time.send("#{form}_time", year, month, day)
  end

  def xmlschema
    to_time.xmlschema
  end

  # Returns the number of days in the date's month.
  #
  #   Date.new(2004,2).days_in_month #=> 28
  #
  #  CREDIT: Ken Kunz.

  def days_in_month
     Date.civil(year, month, -1).day
  end

  def days_of_month
    (1..days_in_month).to_a
  end

  # Get the month name for this date object
  #
  #  CREDIT Benjamin Oakes

  def month_name
    MONTHNAMES[self.month]
  end

  # Convert to a formatted string. See DATE_FORMATS for predefined formats.
  #
  # This method is aliased to <tt>to_s</tt>.
  #
  # ==== Examples:
  #   date = Date.new(2007, 11, 10)       # => Sat, 10 Nov 2007
  #
  #   date.stamp(:db)            # => "2007-11-10"
  #   date.stamp(:short)         # => "10 Nov"
  #   date.stamp(:long)          # => "November 10, 2007"
  #   date.stamp(:rfc822)        # => "10 Nov 2007"
  #
  # == Adding your own formats to stamp
  # You can add your own formats to the Date::FORMAT hash.
  # Use the format name as the hash key and a strftime string
  # as the value. Eg.
  #
  #   Date::FORMAT[:month_and_year] = "%B %Y"
  #
  def stamp(format=:default)
    if formatter = FORMAT[format]
      strftime(formatter)
    else
      to_s
    end
  end

  # Overrides the default inspect method with a human readable one, e.g., "Mon, 21 Feb 2005"
  #def inspect
  #  strftime("%a, %d %b %Y")
  #end

  # Provides precise Date calculations for years, months, and days.  The +options+ parameter takes a hash with 
  # any of these keys: <tt>:years</tt>, <tt>:months</tt>, <tt>:weeks</tt>, <tt>:days</tt>.
  def advance(options)
    d = self
    d = d >> options.delete(:years) * 12 if options[:years]
    d = d >> options.delete(:months)     if options[:months]
    d = d +  options.delete(:weeks) * 7  if options[:weeks]
    d = d +  options.delete(:days)       if options[:days]
    d
  end

  # Returns a new Date where one or more of the elements have been changed according to the +options+ parameter.
  #
  # Examples:
  #
  #   Date.new(2007, 5, 12).change(:day => 1)                  # => Date.new(2007, 5, 1)
  #   Date.new(2007, 5, 12).change(:year => 2005, :month => 1) # => Date.new(2005, 1, 12)
  def change(options)
    ::Date.new(
      options[:year]  || self.year,
      options[:month] || self.month,
      options[:day]   || self.day
    )
  end

  # Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00)
  # and then subtracts the specified number of seconds
  def ago(seconds)
    to_time.since(-seconds)
  end

  # Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00)
  # and then adds the specified number of seconds
  def since(seconds)
    to_time.since(seconds)
  end
  alias :in :since

  # Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00)
  def beginning_of_day
    to_time
  end
  alias :midnight :beginning_of_day

  # Convenience method which returns a new Date/DateTime representing the time 1 day ago
  def yesterday
    self - 1
  end

  # Convenience method which returns a new Date/DateTime representing the time 1 day since the instance time
  def tomorrow
    self + 1
  end

end


class DateTime

  #
  def self.local_offset
    ::Time.local(2007).utc_offset.to_r / 86400
  end

  # Converts self to a Ruby Date object; time portion is discarded
  def to_date
    ::Date.new(year, month, day)
  end

  # Attempts to convert self to a Ruby Time object; returns self if
  # out of range of Ruby Time class, If self has an offset other than 0,
  # self will just be returned unaltered, since there's no clean way
  # to map it to a Time
  def to_time
    self.offset == 0 ? ::Time.utc_time(year, month, day, hour, min, sec) : self
  end

  # To be able to keep Times, Dates and DateTimes interchangeable on conversions
  def to_datetime
    self
  end

  # Convert to a formatted string. See Time::FORMAT for predefined formats.
  # 
  # This method is aliased to <tt>to_s</tt>.
  # 
  # === Examples:
  #   datetime = DateTime.civil(2007, 12, 4, 0, 0, 0, 0)   # => Tue, 04 Dec 2007 00:00:00 +0000
  # 
  #   datetime.stamp(:db)            # => "2007-12-04 00:00:00"
  #   datetime.stamp(:db)            # => "2007-12-04 00:00:00"
  #   datetime.stamp(:number)        # => "20071204000000"
  #   datetime.stamp(:short)         # => "04 Dec 00:00"
  #   datetime.stamp(:long)          # => "December 04, 2007 00:00"
  #   datetime.stamp(:rfc822)        # => "Tue, 04 Dec 2007 00:00:00 +0000"
  #
  # == Adding your own datetime formats to stamp
  # DateTime formats are shared with Time. You can add your own to the
  # Time::FORMAT hash. Use the format name as the hash key and
  # a strftime string as the value. Eg.
  #
  #   Time::FORMAT[:month_and_year] = "%B %Y"
  #
  def stamp(format=:default)
    if formatter = ::Time::FORMAT[format]
      strftime(formatter)
    else
      to_s
    end
  end

  # Seconds since midnight: DateTime.now.seconds_since_midnight
  def seconds_since_midnight
    self.sec + (self.min * 60) + (self.hour * 3600)
  end

  # Returns a new DateTime where one or more of the elements have been
  # changed according to the +options+ parameter. The time options
  # (hour, minute, sec) reset cascadingly, so if only the hour is 
  # passed, then minute and sec is set to 0. If the hour and
  # minute is passed, then sec is set to 0.
  def change(options)
    ::DateTime.civil(
      options[:year]  || self.year,
      options[:month] || self.month,
      options[:day]   || self.day,
      options[:hour]  || self.hour,
      options[:min]   || (options[:hour] ? 0 : self.min),
      options[:sec]   || ((options[:hour] || options[:min]) ? 0 : self.sec),
      options[:offset]  || self.offset,
      options[:start]  || self.start
    )
  end

  # Uses Date to provide precise Time calculations for years, months, and days.
  # The +options+ parameter takes a hash with any of these keys: <tt>:years</tt>,
  # <tt>:months</tt>, <tt>:weeks</tt>, <tt>:days</tt>, <tt>:hours</tt>,
  # <tt>:minutes</tt>, <tt>:seconds</tt>.
  def advance(options)
    d = to_date.advance(options)
    datetime_advanced_by_date = change(:year => d.year, :month => d.month, :day => d.day)
    seconds_to_advance = (options[:seconds] || 0) + (options[:minutes] || 0) * 60 + (options[:hours] || 0) * 3600
    seconds_to_advance == 0 ? datetime_advanced_by_date : datetime_advanced_by_date.since(seconds_to_advance)
  end

  # Returns a new DateTime representing the time a number of seconds ago
  # Do not use this method in combination with x.months, use months_ago instead!
  def ago(seconds)
    self.since(-seconds)
  end

  # Returns a new DateTime representing the time a number of seconds since the instance time
  # Do not use this method in combination with x.months, use months_since instead!
  def since(seconds)
    self + Rational(seconds.round, 86400)
  end
  alias :in :since

  # Returns a new DateTime representing the start of the day (0:00)
  def beginning_of_day
    change(:hour => 0)
  end
  alias :midnight :beginning_of_day

  # Returns a new DateTime representing the end of the day (23:59:59)
  def end_of_day
    change(:hour => 23, :min => 59, :sec => 59)
  end
  
  # Adjusts DateTime to UTC by adding its offset value; offset is set to 0
  #
  # Example:
  #
  #   DateTime.civil(2005, 2, 21, 10, 11, 12, Rational(-6, 24))       # => Mon, 21 Feb 2005 10:11:12 -0600
  #   DateTime.civil(2005, 2, 21, 10, 11, 12, Rational(-6, 24)).utc   # => Mon, 21 Feb 2005 16:11:12 +0000
  def utc
    new_offset(0)
  end
  alias_method :getutc, :utc
  
  # Returns true if offset == 0
  def utc?
    offset == 0
  end
  
  # Returns the offset value in seconds
  def utc_offset
    (offset * 86400).to_i
  end

  # Converts datetime to an appropriate format for use in XML
  def xmlschema
    strftime("%Y-%m-%dT%H:%M:%S%Z")
  end if RUBY_VERSION < '1.9'

  # Converts self to a floating-point number of seconds since the Unix epoch 
  def to_f
    days_since_unix_epoch = self - ::DateTime.civil(1970)
    (days_since_unix_epoch * 86_400).to_f
  end

end


class Time

  public :to_date
  public :to_datetime

  # Converts a Time object to a Date, dropping hour, minute, and second precision.
  #
  #   my_time = Time.now  # => Mon Nov 12 22:59:51 -0500 2007
  #   my_time.to_date     # => Mon, 12 Nov 2007
  #
  #   your_time = Time.parse("1/13/2009 1:13:03 P.M.")  # => Tue Jan 13 13:13:03 -0500 2009
  #   your_time.to_date                                 # => Tue, 13 Jan 2009
  def to_date
    ::Date.new(year, month, day)
  end

  #  # Convert a Time to a Date. Time is a superset of Date.
  #  # It is the year, month and day that are carried over.
  #
  #  def to_date
  #    require 'date' # just in case
  #    jd = Date.__send__(:civil_to_jd, year, mon, mday, Date::ITALY)
  #    Date.new!(Date.__send__(:jd_to_ajd, jd, 0, 0), 0, Date::ITALY)
  #  end


  # Converts a Time instance to a Ruby DateTime instance, preserving UTC offset.
  #
  #   my_time = Time.now    # => Mon Nov 12 23:04:21 -0500 2007
  #   my_time.to_datetime   # => Mon, 12 Nov 2007 23:04:21 -0500
  #
  #   your_time = Time.parse("1/13/2009 1:13:03 P.M.")  # => Tue Jan 13 13:13:03 -0500 2009
  #   your_time.to_datetime                             # => Tue, 13 Jan 2009 13:13:03 -0500
  def to_datetime
    ::DateTime.civil(year, month, day, hour, min, sec, Rational(utc_offset, 86400))
  end

end


class String

  # Convert string to DateTime.
  def to_datetime
    date = ::Date._parse(self, false).values_at(:year, :mon, :mday, :hour, :min, :sec).map { |arg| arg || 0 }
    ::DateTime.civil(*date)
  end

  # Parse data from string.
  def to_date
    #::Date::civil(*ParseDate.parsedate(self)[0..2])
    ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday))
  end

end

