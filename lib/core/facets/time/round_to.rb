require 'facets/time/trunc'

class Time

  unless method_defined?(:round)

    # Round time at the nearest range (in seconds).
    #
    #   t1 = Time.now
    #   t2 = t1.round(60*60)
    #   t2.min #=> 0
    #   t2.sec #=> 0
    #
    # TODO: This is kind of weird. Better would be `round(:minute)`.
    def round(amount)
      (self+amount/2.0).trunc(amount)
    end

  end

end

