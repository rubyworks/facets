unless (RUBY_VERSION[0,3] == '1.9')

  class String

    # Returns an array of characters.
    #
    #   "abc\n123".lines  #=> ["abc","123"]

    def lines
      self.split(/\n/)
    end

  end

end

