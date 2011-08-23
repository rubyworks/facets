class File

  # Read in a file as binary data.
  #
  # Assuming we had a binary file 'binary.dat'.
  #
  #   File.read_binary('binary.dat')
  #
  # CREDIT: George Moschovitis

  def self.read_binary(fname)
    open(fname, 'rb') do |f|
      return f.read
    end
  end

end

