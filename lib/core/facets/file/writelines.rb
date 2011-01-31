class File

  # Writes the given array of data to the given path and closes the file.
  # This is done in binary mode, complementing <tt>IO.readlines</tt> in
  # standard Ruby.
  #
  # Note that +readlines+ (the standard Ruby method) returns an array of lines
  # <em>with newlines intact</em>, whereas +writelines+ uses +puts+, and so
  # appends newlines if necessary.  In this small way, +readlines+ and
  # +writelines+ are not exact opposites.
  #
  #   data = ['The content', ['for the file']]
  #   File.writelines('tmp/writelines.txt', data)
  #
  # Returns number of lines written.
  #
  # CREDIT: Noah Gibbs, Gavin Sinclair

  def self.writelines(path, data)
    File.open(path, "wb") do |file|
      file.puts(data)
    end
    data.size
  end

end

