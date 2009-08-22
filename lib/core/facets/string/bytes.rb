class String

  unless method_defined?(:bytes) # 1.8.7+

    # Upacks string into bytes.
    #
    # Note, this is not 100% compatible with 1.8.7+
    # which returns an enumerator instead of an array.
    #
    def bytes(&blk)
      if block_given?
        self.unpack('C*').each(&blk)
      else
        self.unpack('C*')
      end
    end

  end

end

