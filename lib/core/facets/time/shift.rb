require 'facets/time/set'
require 'facets/time/dst_adjustment'

class Time

  # TODO: Deprecate use of #dst-adjustment in Time#shift ?

  # Returns a new Time representing the time shifted by the time-units given.
  # Positive number shift the time forward, negative number shift the time 
  # backward.
  #
  #   t = Time.utc(2010,10,10,0,0,0)
  #   t.shift( 4, :days)            #=>  Time.utc(2010,10,14,0,0,0)
  #   t.shift(-4, :days)            #=>  Time.utc(2010,10,6,0,0,0)
  #
  # More than one unit of time can be given.
  #
  #   t.shift(4, :days, 3, :hours)  #=>  Time.utc(2010,10,14,3,0,0)
  #
  # The #shift method can also take a hash.
  #
  #   t.shift(:days=>4, :hours=>3)  #=>  Time.utc(2010,10,14,3,0,0)
  #
  def shift(*time_units)
    time_hash = Hash===time_units.last ? time_units.pop : {}
    time_units = time_units.flatten
    time_units << :seconds if time_units.size % 2 == 1
    time_hash.each{ |units, number| time_units << number; time_units << units }

    time = self
    time_units.each_slice(2) do |number, units|
      #next time = time.ago(-number, units) if number < 0
      time = (
        case units.to_s.downcase.to_sym
        when :years, :year
          time.set( :year=>(year + number) )
        when :months, :month
          if number > 0
            new_month = ((month + number - 1) % 12) + 1
            y = (number / 12) + (new_month < month ? 1 : 0)
            time.set(:year => (year + y), :month => new_month)
          else
            number = -number
            new_month = ((month - number - 1) % 12) + 1
            y = (number / 12) + (new_month > month ? 1 : 0)
            time.set(:year => (year - y), :month => new_month)
          end
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

  # Alias for #shift.
  alias_method :in, :shift

  # Alias for #shift.
  alias_method :hence, :shift unless method_defined?(:hence)

  # Returns a new Time representing the time a number of time-units ago.
  # This is just like #shift, but reverses the direction.
  #
  #   t = Time.utc(2010,10,10,0,0,0)
  #
  #   t.less(4, :days)             #=>  Time.utc(2010,10,6,0,0,0)
  #
  def less(*time_units)
    time_hash  = Hash===time_units.last ? time_units.pop : {}
    time_units = time_units.flatten

    time_units << :seconds if time_units.size % 2 == 1

    time_hash.each{ |units, number| time_units << number; time_units << units }

    neg_times = []
    time_units.each_slice(2){ |number, units| neg_times << -number; neg_times << units }

    shift(*neg_times)
  end

  # Alias for #less
  alias_method :ago, :less unless method_defined?(:ago)

end

