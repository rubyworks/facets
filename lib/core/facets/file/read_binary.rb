class File

  # Read in a file as binary data.
  #
  # CREDIT: George Moschovitis

  def self.read_binary(fname)
    open(fname, 'rb') {|f|
      return f.read
    }
  end

end

