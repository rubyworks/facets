class File

  # Takes a file name string and returns or changes its extension.
  #
  #   ext()
  #
  # returns extension of this file name.
  #
  #   ext(new_ext)
  #
  # changes exension of this file name to _new_ext_ and returns changed
  # file name.
  #
  # Examples:
  #
  #   File.ext('file.rb')          => 'rb'
  #   File.ext('file.rb', 'txt')   => 'file.txt'
  #   File.ext('file.rb', '')      => 'file'
  #
  # Can be used with String#file for more object-oriented approach.
  #
  #   'file.rb'.file.ext('txt')   => 'file.txt'
  #
  # Unlike #extname this method does not include the extension dot.

  def self.ext(string, new_ext=nil)
    if new_ext == nil
      extname(string).sub(/^\./, '')
    else
      old_ext = File.extname(string)
      new_ext = '.' + new_ext unless (new_ext[0,1] == '.' || new_ext.empty?)
      string.chomp(old_ext) + new_ext
      #if old_ext == '' then return string + new_ext
      #else return string[0...-old_ext.length] + new_ext; end
    end
  end

end

