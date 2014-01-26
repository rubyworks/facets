class String
  # Get a new string with non-ASCII characters removed.
  #
  # alt - String to replace non-ASCII characters with.
  #       Defaults to a blank string (`''`).
  #
  # Examples
  #
  #   'abc'.ascii_only     #=> 'abc'
  #   '中文123'.ascii_only  #=> '123'
  #
  # Returns a copy of [String] with ASCII characters only.
  #
  # CREDIT: Nathan Long
  #
  # SEE: http://stackoverflow.com/questions/1268289
  def ascii_only(alt='')
    encoding_options = {
      :invalid                     => :replace,  # Replace invalid byte sequences
      :undef                       => :replace,  # Replace anything not defined in ASCII
      :replace                     => alt,       # Use a blank for those replacements
      :UNIVERSAL_NEWLINE_DECORATOR => true       # Always break lines with \n
    }
    self.encode(Encoding.find('ASCII'), encoding_options)
  end

  # Modify string keeping only ASCII characters.
  #
  # alt - String to replace non-ASCII characters with.
  #       Defaults to a blank string (`''`).
  # 
  # Examples
  #
  #   'abc'.ascii_only!     #=> 'abc'
  #   '中文123'.ascii_only!  #=> '123'
  #
  # Returns [String]
  #
  # CREDIT: Nathan Long
  #
  # SEE: http://stackoverflow.com/questions/1268289
  def ascii_only!(alt='')
    encoding_options = {
      :invalid                     => :replace,  # Replace invalid byte sequences
      :undef                       => :replace,  # Replace anything not defined in ASCII
      :replace                     => alt,       # Use a blank for those replacements
      :UNIVERSAL_NEWLINE_DECORATOR => true       # Always break lines with \n
    }
    self.encode!(Encoding.find('ASCII'), encoding_options)
  end

end
