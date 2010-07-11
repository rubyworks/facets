class File

  unless defined?(write)  # 1.9+

    # Writes the given data to the given path and closes the file.  This is
    # done in binary mode, complementing <tt>IO.read</tt> in standard Ruby.
    #
    #   str = 'The content for the file'
    #   File.write('tmp/write.txt', str)
    #
    # Returns the number of bytes written.
    #
    # CREDIT: Gavin Sinclair

    def self.write(path, data)
      File.open(path, "wb") do |file|
        return file.write(data)
      end
    end

  end

end

