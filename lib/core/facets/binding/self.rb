class Binding

  # @deprecated Use Binding#receiver instead (built-in since Ruby 2.6).
  def self
    warn "Binding#self is deprecated. Use Binding#receiver instead.", uplevel: 1
    receiver
  end

end
