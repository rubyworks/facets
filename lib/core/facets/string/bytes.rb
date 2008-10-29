unless (RUBY_VERSION[0,3] == '1.9')

  class String

    # Upacks string into bytes.
    #
    #
    def bytes
      self.unpack('C*')
    end

  end

end

