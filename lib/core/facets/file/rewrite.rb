class File

  # Opens a file as a string and writes back the string to the file at
  # the end of the block.
  #
  # Returns the number of written bytes or +nil+ if the file wasn't
  # modified.
  #
  # Note that the file will even be written back in case the block
  # raises an exception.
  #
  # Mode can either be "b" or "+" and specifies to open the file in
  # binary mode (no mapping of the plattform's newlines to "\n" is
  # done) or to append to it.
  #
  # Assuming we had a file 'message.txt' and had a binary file 'binary.dat'.
  #
  #   # Reverse contents of "message.txt"
  #   File.rewrite("tmp/message.txt") { |str| str.reverse }
  #
  #   # Replace "foo" by "bar" in "binary.dat".
  #   File.rewrite("tmp/binary.dat", "b") { |str| str.gsub("foo", "bar") }
  #
  # IMPORTANT: The old version of this method required in place modification
  # of the file string. The new version will write whatever the block
  # returns instead!!!
  #
  # CREDIT: George Moschovitis
  #
  def self.rewrite(name, mode = "") #:yield:
    unless block_given?
      raise(ArgumentError, "Need to supply block to File.rewrite")
    end

    if mode.is_a?(Numeric) then
      flag, mode = mode, ""
      mode += "b" if flag & File::Constants::BINARY != 0
      mode += "+" if flag & File::Constants::APPEND != 0
    else
      mode.delete!("^b+")
    end

    old_str = open(name, "r#{mode}") { |file| file.read } #rescue ""
    old_str = old_str.clone

    begin
      new_str = yield(old_str)
    ensure
      if old_str != new_str
        open(name, "w#{mode}") { |file| file.write(new_str) }
      end
    end
  end

  # In place version of #rewrite. This version of method requires that the
  # string be modified in place within the block.
  #
  #   # Reverse contents of "message"
  #   File.rewrite("tmp/message.txt") { |str| str.reverse! }
  #
  #   # Replace "foo" by "bar" in "binary"
  #   File.rewrite("tmp/binary.dat", "b") { |str| str.gsub!("foo", "bar") }
  #
  def self.rewrite!(name, mode = "") #:yield:
    unless block_given?
      raise(ArgumentError, "Need to supply block to File.rewrite")
    end

    if mode.is_a?(Numeric) then
      flag, mode = mode, ""
      mode += "b" if flag & File::Constants::BINARY != 0
      mode += "+" if flag & File::Constants::APPEND != 0
    else
      mode.delete!("^b+")
    end

    old_str = open(name, "r#{mode}") { |file| file.read } #rescue ""
    new_str = old_str.clone

    begin
      yield(new_str)
    ensure
      if old_str != new_str
        open(name, "w#{mode}") { |file| file.write(str) }
      end
    end
  end

end

