# DEPRECATE
require 'facets/file/create'
require 'facets/file/append'
require 'facets/file/writelines'

class File

  # Writes the given data to the given path and closes the file.  This is
  # done in binary mode, complementing <tt>IO.read</tt> in standard Ruby.
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

