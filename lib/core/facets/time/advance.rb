class Time

  # Uses Date to provide precise Time calculations for years, months, and days.
  # The +options+ parameter takes a hash with any of these keys: <tt>:years</tt>,
  # <tt>:months</tt>, <tt>:weeks</tt>, <tt>:days</tt>, <tt>:hours</tt>,
  # <tt>:minutes</tt>, <tt>:seconds</tt>.
  #
  #   CREDIT: ActiveSupport
  def advance(options)
    d = to_date.advance(options)
    time_advanced_by_date = change(:year => d.year, :month => d.month, :day => d.day)
    seconds_to_advance = (options[:seconds] || 0) + (options[:minutes] || 0) * 60 + (options[:hours] || 0) * 3600
    seconds_to_advance == 0 ? time_advanced_by_date : time_advanced_by_date.since(seconds_to_advance)
  end

end

