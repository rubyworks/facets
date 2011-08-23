class String

  unless method_defined?(:lines)  # 1.8.7+

    # Returns an array of characters.
    #
    #   "abc\n123".lines.to_a  #=> ["abc\n","123"]
    #
    def lines(&blk)
      if block_given?
        each_line(&blk) #scan(/$.*?\n/).each(&blk)
      else
        Enumerator.new(self, :lines) #.split(/\n/)
      end
    end

  end

end
