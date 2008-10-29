class String

  unless defined? each_char # 1.9

    require 'strscan'

    # Iterates through each character. This is a little faster than
    # using #chars b/c it does not create the intermediate array.
    #
    #    a = ''
    #   "HELLO".each_character{ |c| a << #{c.downcase} }
    #    a  #=> 'hello'

    #def each_char  # :yield:
    #  size.times do |i|
    #    yield(self[i,1])
    #  end
    #end

    # Yields a single-character string for each character in the string.
    # When $KCODE = 'UTF8', multi-byte characters are yielded appropriately.
    def each_char
      scanner, char = StringScanner.new(self), /./mu
      loop { yield(scanner.scan(char) || break) }
    end

  end

end
