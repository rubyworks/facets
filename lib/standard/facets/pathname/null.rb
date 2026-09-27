class Pathname

  # @deprecated Use Pathname.new(File::NULL) instead.
  #   Scheduled for removal after 2027-09-30.
  def self.null
    warn "Pathname.null is deprecated. Use Pathname.new(File::NULL) instead. It will be removed after 2027-09-30.", uplevel: 1
    new(File::NULL)
  end

end
