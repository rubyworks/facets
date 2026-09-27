class Time

  unless method_defined?(:to_time) # 1.9

    # To be able to keep Dates and Times interchangeable
    # on conversions.
    #
    # @deprecated Ruby defines Time#to_time once 'date' is loaded.
    #   Scheduled for removal after 2027-09-30.
    #
    def to_time
      warn "Facets' Time#to_time is deprecated. Require 'date' for Ruby's own Time#to_time. " \
           "It will be removed after 2027-09-30.", uplevel: 1
      getlocal
    end

    # A method to keep Time, Date and DateTime instances interchangeable
    # on conversions. In this case, it simply returns +self+.
    #def to_time
    #  self
    #end

  end

end

