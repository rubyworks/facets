class File

  # Read in a file as binary data.
  #
  # Assuming we had a binary file 'tmp/binary.dat'.
  #
  #   File.read_binary('tmp/binary.dat')
  #
  # CREDIT: George Moschovitis

  def self.read_binary(fname)
    open(fname, 'rb') do |f|
      return f.read
    end
  end

end

