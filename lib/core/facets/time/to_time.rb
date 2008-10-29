class Time

  unless defined? to_time #1.9

    # To be able to keep Dates and Times interchangeable
    # on conversions.

    def to_time
      getlocal 
    end

    # A method to keep Time, Date and DateTime instances interchangeable on conversions.
    # In this case, it simply returns +self+.
    #def to_time
    #  self
    #end

  end

end

