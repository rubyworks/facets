class Time

  unless const_defined?('FORMAT')
    FORMAT = {
      :db      => "%Y-%m-%d %H:%M:%S",
      :dbase   => "%Y-%m-%d %H:%M:%S",
      :datbase => "%Y-%m-%d %H:%M:%S",
      :utc     => "%Y-%m-%d %H:%M:%S",
      :number  => "%Y%m%d%H%M%S",
      :short   => "%d %b %H:%M",
      :time    => "%H:%M",
      :long    => "%B %d, %Y %H:%M",
      :day1st  => "%d-%m-%Y %H:%M",
      :dmYHM   => "%d-%m-%Y %H:%M",
      :rfc822  => "%a, %d %b %Y %H:%M:%S %z",
      nil      => "%a %b %d %H:%M:%S %Z %Y"
    }
  end

  # Produce time stamp for Time.now. See #stamp.
  #
  # CREDIT: Trans

  def self.stamp(*args)
    now.stamp(*args)
  end

  # Create a time stamp.
  #
  #   t = Time.at(10000)
  #   t.stamp(:short)    #=> "31 Dec 21:46"
  #
  # Supported formats come from the Time::FORMAT constant.
  #
  # CREDIT: Trans

  def stamp(fmt = nil)
    unless String === fmt
      fmt = FORMAT[fmt]
    end
    strftime(fmt).strip
  end

end

