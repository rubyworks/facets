class String

  unless defined?(chars) or defined?(::ActiveSupport) # 1.9 & ActiveSupport

    # Returns an array of characters.
    #
    #   "abc".chars  #=> ["a","b","c"]

    def chars
      split(//)
    end

  end

end

