class Array

  # Turn an array into a file path.
  #
  #   ["usr", "local", "lib"].to_path  #=> "usr/local/lib"
  #
  #  CREDIT: Trans

  def to_path
    File.join( *(self.compact) )
  end

end

