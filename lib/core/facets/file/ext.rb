class File

  # Takes a file name string and returns or changes its extension.
  #
  # Without a new extension argument, returns the extension of the
  # file name. In this respect #ext is like #extname, but unlike
  # #extname it does not include the dot prefix.
  #
  # With a new extension argument, changes the exension of the file
  # name to the new extension and returns it.
  #
  # Examples:
  #
  #   File.ext('file.rb')          => 'rb'
  #   File.ext('file.rb', 'txt')   => 'file.txt'
  #   File.ext('file.rb', '.txt')  => 'file.txt'
  #   File.ext('file.rb', '')      => 'file'
  #
  # This method can be used with String#file for more object-oriented notation.
  #
  #   'file.rb'.file.ext('txt')   => 'file.txt'
  #
  # CREDIT: Lavir the Whiolet

  def self.ext(filename, new_ext=nil)
    old_ext = extname(filename)
    if new_ext == nil
      old_ext.sub(/^\./, '')
    else
      new_ext = '.' + new_ext unless (new_ext.empty? || new_ext[0,1] == '.')
      filename.chomp(old_ext) + new_ext
    end
  end

end

