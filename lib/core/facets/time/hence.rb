require 'facets/time/set'
require 'facets/time/dst_adjustment'

class Time

  unless method_defined?(:ago)

    # Returns a new Time representing the time
    # a number of time-units ago.
    #
    def ago(number, units=:seconds)
      return hence(-number, units) if number < 0

      time = (
        case units.to_s.downcase.to_sym
        when :years
          set(:year => (year - number))
        when :months
          new_month = ((month - number - 1) % 12) + 1
          y = (number / 12) + (new_month > month ? 1 : 0)
          set(:year => (year - y), :month => new_month)
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

  end

  unless method_defined?(:hence)

    # Returns a new Time representing the time a number of
    # time-units hence.
    def hence(number, units=:seconds)
      return ago(-number, units) if number < 0

      time = (
        case units.to_s.downcase.to_sym
        when :years
          set( :year=>(year + number) )
        when :months
          new_month = ((month + number - 1) % 12) + 1
          y = (number / 12) + (new_month < month ? 1 : 0)
          set(:year => (year + y), :month => new_month)
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

  end

  # Alias for #hence.
  alias_method :in, :hence unless method_defined?(:in)

  # Alias for #hence.
  alias_method :since, :hence unless method_defined?(:since)

end

