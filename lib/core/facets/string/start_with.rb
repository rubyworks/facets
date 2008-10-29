unless (RUBY_VERSION[0,3] == '1.9')

  class String

    # Does a string start with the given prefix.
    #
    #   "hello".starts_with?("he")    #=> true
    #   "hello".starts_with?("to")    #=> false
    #
    #  CREDIT: Lucas Carlson
    #  CREDIT: Blaine Cook

    def start_with?(prefix)
      self.index(prefix) == 0
    end

    # Does a string end with the given suffix?
    #
    #   "hello".ends_with?("lo")    #=> true
    #   "hello".ends_with?("to")    #=> false
    #
    #  CREDIT: Lucas Carlson
    #  CREDIT: Blaine Cook

    def end_with?(suffix)
      self.rindex(suffix) == size - suffix.size
    end

  end

end

