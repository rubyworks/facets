class Time

  # Like change but does not reset earlier times.
  #
  # NOTE: It would be better, probably if this were called "change".
  # and that #change were called "reset".
  #
  def set(options)
    opts={}
    options.each_pair do |k,v| 
      k = :min if k.to_s =~ /^min/
      k = :sec if k.to_s =~ /^sec/
      opts[k] = v.to_i 
    end
    self.class.send(
      self.utc? ? :utc : :local,
      opts[:year]  || self.year,
      opts[:month] || self.month,
      opts[:day]   || self.day,
      opts[:hour]  || self.hour,
      opts[:min]   || self.min,
      opts[:sec]   || self.sec,
      opts[:usec]  || self.usec
    )
  end

end
