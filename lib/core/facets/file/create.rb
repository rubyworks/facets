class File

  # Creates a new file, or overwrites an existing file,
  # and writes a string into it. Can also take a block
  # just like File#open, which is yielded _after_ the
  # string is writ.
  #
  #   str = 'The content for the file'
  #   File.create('tmp/myfile.txt', str)
  #
  # CREDIT: George Moschovitis

  def self.create(path, str='', &blk)
    open(path, 'wb') do |f|
      f << str
      blk.call(f) if blk
    end
  end

end

