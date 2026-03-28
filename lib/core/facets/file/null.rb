class File

  # @deprecated Use File::NULL constant instead (built-in since Ruby 1.9.3).
  def self.null
    warn "File.null is deprecated. Use File::NULL instead.", uplevel: 1
    File::NULL
  end

end
