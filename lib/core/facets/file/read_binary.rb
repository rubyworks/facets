class File

  # @deprecated Use File.binread instead (built-in since Ruby 1.9.3).
  def self.read_binary(fname)
    warn "File.read_binary is deprecated. Use File.binread instead.", uplevel: 1
    binread(fname)
  end

end
