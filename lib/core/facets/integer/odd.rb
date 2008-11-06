class Integer

  if RUBY_VERSION < '1.9'

    # Returns true if this integer is odd, false otherwise.
    #
    #   2.odd?            #=> false
    #   3.odd?            #=> true
    #
    #   -99.odd?          # -> true
    #   -98.odd?          # -> false
    #
    # CREDIT: Daniel Schierbeck

    def odd?
      #self % 2 == 1
      self & 1 == 1
    end

    # Returns true if this integer is even, false otherwise.
    #
    #   2.even?  #=> true
    #   3.even?  #=> false
    #
    # CREDIT: Daniel Schierbeck

    def even?
      #self % 2 == 0
      self & 1 == 0
    end

  end

end

