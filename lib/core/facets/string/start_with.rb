class String

  unless method_defined?(:start_with?) # 1.8.7+

    # Does a string start with the given prefix?
    #
    #   "hello".start_with?("he")    #=> true
    #   "hello".start_with?("to")    #=> false
    #
    # CREDIT: Lucas Carlson, Blaine Cook

    def start_with?(prefix)
      self.index(prefix) == 0
    end

  end

  unless method_defined?(:end_with?) # 1.8.7+

    # Does a string end with the given suffix?
    #
    #   "hello".end_with?("lo")    #=> true
    #   "hello".end_with?("to")    #=> false
    #
    # CREDIT: Lucas Carlson, Blaine Cook

    def end_with?(suffix)
      self.rindex(suffix) == size - suffix.size
    end

  end

  alias_method :starts_with?, :start_with?
  alias_method :ends_with?  , :end_with?

end

