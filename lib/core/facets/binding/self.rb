class Binding

  # @deprecated Use Binding#receiver instead (built-in since Ruby 2.6).
  #   Scheduled for removal after 2027-09-30.
  def self
    warn "Binding#self is deprecated. Use Binding#receiver instead. It will be removed after 2027-09-30.", uplevel: 1
    receiver
  end

end
