class String

  unless method_defined?(:each_char) # 1.9

    require 'strscan'

    # Yields a single-character string for each character in the string.
    # When $KCODE = 'UTF8', multi-byte characters are yielded appropriately.
    #
    #   a = ''
    #   "HELLO".each_char{ |c| a << "#{c.downcase}" }
    #   a  #=> 'hello'
    #
    def each_char # :yield:
      scanner, char = StringScanner.new(self), /./mu
      loop{ yield(scanner.scan(char) || break) }
    end

    #--
    # Iterates through each character. This is a little faster than
    # using #chars b/c it does not create the intermediate array...
    #
    #   def each_char  # :yield:
    #     size.times{ |i| yield(self[i,1]) }
    #   end
    #++

  end

end

