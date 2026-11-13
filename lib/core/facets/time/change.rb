class Time

  # Returns a new Time where one or more of the elements
  # have been changed according to the +options+ parameter.
  # The time options (hour, min, sec, usec) reset
  # cascadingly, so if only the hour is passed, then
  # minute, sec, and usec is set to 0. If the hour and
  # minute is passed, then sec and usec is set to 0.
  #
  #   t1 = Time.at(10000, in: "-05:00")
  #   t1.ctime   #=> "Wed Dec 31 21:46:40 1969"
  #
  #   t2 = t1.change(:hour => 11)
  #   t2.ctime   #=> "Wed Dec 31 11:00:00 1969"
  #
  # The options are :year, :month, :day, :hour, :min, :sec, :usec, :nsec
  # and :offset. The new time keeps this time's UTC offset or time zone,
  # unless :offset gives a new one.
  #
  #   t = Time.new(2026, 11, 4, 15, 30, 0, "+09:00")
  #   t.change(hour: 1).to_s            #=> "2026-11-04 01:00:00 +0900"
  #   t.change(offset: "+01:00").to_s   #=> "2026-11-04 15:30:00 +0100"
  #
  # It takes the same options and gives the same results as ActiveSupport's
  # Time#change, so the two agree whichever is loaded.
  #
  def change(options)
    year  = options.fetch(:year,  self.year)
    month = options.fetch(:month, self.month)
    day   = options.fetch(:day,   self.day)
    hour  = options.fetch(:hour,  self.hour)
    min   = options.fetch(:min,   options[:hour] ? 0 : self.min)
    sec   = options.fetch(:sec,   (options[:hour] || options[:min]) ? 0 : self.sec)

    if options[:nsec]
      raise ArgumentError, "can't change both :nsec and :usec: #{options.inspect}" if options[:usec]
      usec = Rational(options[:nsec], 1000)
    else
      reset = options[:hour] || options[:min] || options[:sec]
      usec  = options.fetch(:usec, reset ? 0 : Rational(nsec, 1000))
    end
    raise ArgumentError, "argument out of range" if usec >= 1_000_000
    sec += Rational(usec, 1_000_000)

    if options[:offset]
      self.class.new(year, month, day, hour, min, sec, options[:offset])
    elsif utc?
      self.class.utc(year, month, day, hour, min, sec)
    elsif zone.respond_to?(:utc_to_local)
      # A time zone object, e.g. from TZInfo.
      time = self.class.new(year, month, day, hour, min, sec, zone)
      time += 0 unless time.utc_offset.integer?  # a Ruby bug before 3.2.4 and 3.3.1
      # In the hour that repeats when daylight saving time ends, Time.new
      # picks the earlier of the two times. Pick the one with this time's
      # offset instead, if that's the later one.
      shift = time.utc_offset - utc_offset
      later = time + shift if shift > 0
      later && later.utc_offset == utc_offset ? later : time
    elsif zone
      # Local time. isdst picks the right time in the hour that repeats.
      self.class.local(sec, min, hour, day, month, year, nil, nil, isdst, nil)
    else
      # A fixed UTC offset, e.g. +09:00.
      self.class.new(year, month, day, hour, min, sec, utc_offset)
    end
  end

end
