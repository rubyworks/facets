class File

  # Append to a file.
  #
  # CREDIT: George Moschovitis

  def self.append(file, str)
    File.open(file, 'ab') { |f|
      f << str
    }
  end

end

