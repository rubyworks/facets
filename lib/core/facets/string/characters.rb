class String

  # Some other library is defining this method but it is
  # returning an Enumerator, not an array. Therefore we're
  # overriding it regardless of it's inclusion in 1.9.
  #
  unless defined?(::ActiveSupport) # 1.9 & ActiveSupport

    # Returns an array of characters.
    #
    #   "abc".chars  #=> ["a","b","c"]
    #
    def chars
      split(//)
    end

  end

end

