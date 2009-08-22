class String

  unless method_defined?(:lines)  # 1.8.7+

    # Returns an array of characters.
    #
    #   "abc\n123".lines  #=> ["abc","123"]
    #
    # Note, this is not 100% compatible with 1.8.7+
    # which returns an enumerator instead of an array.
    #
    def lines(&blk)
      if block_given?
        self.split(/\n/).each(&blk)
      else
        self.split(/\n/)
      end
    end

  end

end
