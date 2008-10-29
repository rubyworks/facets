require 'facets/time/set'

class Time

  if defined?(::ActiveSupport)

    alias_method :in, :since
    alias_method :hence, :since

  else

    # Returns a new Time representing the time
    # a number of time-units ago.
    #
    def ago(number, units=:seconds)
      time =(
        case units.to_s.downcase.to_sym
        when :years
          set(:year => (year - number))
        when :months
          #years = ((month - number) / 12).to_i
          y = ((month - number) / 12).to_i
          m = ((month - number - 1) % 12) + 1
          set(:year => (year - y), :month => m)
        when :weeks
          self - (number * 604800)
        when :days
          self - (number * 86400)
        when :hours
          self - (number * 3600)
        when :minutes
          self - (number * 60)
        when :seconds, nil
          self - number
        else
          raise ArgumentError, "unrecognized time units -- #{units}"
        end
      )
      dst_adjustment(time)
    end
    #
    # Returns a new Time representing the time
    # a number of time-units hence.

    def hence(number, units=:seconds)
      time =(
        case units.to_s.downcase.to_sym
        when :years
          set( :year=>(year + number) )
        when :months
          y = ((month + number) / 12).to_i
          m = ((month + number - 1) % 12) + 1
          set(:year => (year + y), :month => m)
        when :weeks
          self + (number * 604800)
        when :days
          self + (number * 86400)
        when :hours
          self + (number * 3600)
        when :minutes
          self + (number * 60)
        when :seconds
          self + number
        else
          raise ArgumentError, "unrecognized time units -- #{units}"
        end
      )
      dst_adjustment(time)
    end

    alias_method :in, :hence
    alias_method :since, :hence

    # Adjust DST
    #
    # TODO: Can't seem to get this to pass ActiveSupport tests.
    #       Even though it is essentially identical to the
    #       ActiveSupport code (see Time#since in time/calculations.rb).
    #       It handels all but 4 tests.
    def dst_adjustment(time)
      self_dst = self.dst? ? 1 : 0
      time_dst = time.dst? ? 1 : 0
      seconds  = (self - time).abs
      if (seconds >= 86400 && self_dst != time_dst)
        time + ((self_dst - time_dst) * 60 * 60)
      else
        time
      end
    end

  end

end

