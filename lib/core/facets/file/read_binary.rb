class File

  # @deprecated Use File.binread instead (built-in since Ruby 1.9.3).
  #   Scheduled for removal after 2027-09-30.
  def self.read_binary(fname)
    warn "File.read_binary is deprecated. Use File.binread instead. It will be removed after 2027-09-30.", uplevel: 1
    binread(fname)
  end

end
