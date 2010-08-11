require 'facets/time/set'
require 'facets/time/dst_adjustment'

class Time

  # Returns a new Time representing the time a number of
  # time-units in the futue.
  #
  #   t = Time.utc(2010,10,10,12,0,0)
  #
  #   t.in(4, :days)             #=>  Time.utc(2010,10,14,0,0,0)
  #
  # More than one unit of time can be given.
  #
  #   t.in(4, :days, 3, :hours)  #=>  Time.utc(2010,10,14,3,0,0)
  #
  # The #in method can also take a hash.
  #
  #   t.in(:days=>4, :hours=>3)  #=>  Time.utc(2010,10,14,3,0,0)
  #
  def in(*time_units)
    time_hash = Hash===time_units.last ? time_units.pop : {}
    time_units << :seconds if time_units.size % 2 == 1
    time_hash.each{ |units, number| time_units << [number, units] }
    time = self
    time_units.each_slice(2) do |number, units|
      next time = time.ago(-number, units) if number < 0
      time = (
        case units.to_s.downcase.to_sym
        when :years, :year
          time.set( :year=>(year + number) )
        when :months, :month
          new_month = ((month + number - 1) % 12) + 1
          y = (number / 12) + (new_month < month ? 1 : 0)
          time.set(:year => (year + y), :month => new_month)
        when :weeks, :week
          time + (number * 604800)
        when :days, :day
          time + (number * 86400)
        when :hours, :hour
          time + (number * 3600)
        when :minutes, :minute, :mins, :min
          time + (number * 60)
        when :seconds, :second, :secs, :sec, nil
          time + number
        else
          raise ArgumentError, "unrecognized time units -- #{units}"
        end
      )
    end
    dst_adjustment(time)
  end

  # Returns a new Time representing the time
  # a number of time-units ago.
  #
  def ago(*time_units)
    time_hash = Hash===time_units.last ? time_units.pop : {}
    time_units << :seconds if time_units.size % 2 == 1    
    time_hash.each{ |units, number| time_units << [number, units] }
    time = self
    time_units.each_slice(2) do |number, units|
      next time = time.in(-number, units) if number < 0
      time = (
        case units.to_s.downcase.to_sym
        when :years, :year
          time.set(:year => (year - number))
        when :months, :month
          new_month = ((month - number - 1) % 12) + 1
          y = (number / 12) + (new_month > month ? 1 : 0)
          time.set(:year => (year - y), :month => new_month)
        when :weeks, :week
          time - (number * 604800)
        when :days, :day
          time - (number * 86400)
        when :hours, :hour
          time - (number * 3600)
        when :minutes, :minute, :mins, :min
          time - (number * 60)
        when :seconds, :second, :secs, :sec, nil
          time - number
        else
          raise ArgumentError, "unrecognized time units -- #{units}"
        end
      )
    end
    dst_adjustment(time)
  end unless method_defined?(:ago)

  # Alias for #in.
  alias_method :hence, :in unless method_defined?(:hence)

end
