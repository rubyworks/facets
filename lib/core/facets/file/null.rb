class File

  # @deprecated Use File::NULL constant instead (built-in since Ruby 1.9.3).
  #   Scheduled for removal after 2027-09-30.
  def self.null
    warn "File.null is deprecated. Use File::NULL instead. It will be removed after 2027-09-30.", uplevel: 1
    File::NULL
  end

end
