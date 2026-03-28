module Comparable

  # @deprecated Use Comparable#clamp instead (built-in since Ruby 2.4).
  def clip(lower, upper=nil)
    warn "Comparable#clip is deprecated. Use Comparable#clamp instead.", uplevel: 1
    upper ? clamp(lower, upper) : clamp(lower..)
  end

end
