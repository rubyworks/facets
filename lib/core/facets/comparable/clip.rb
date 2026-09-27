module Comparable

  # @deprecated Use Comparable#clamp instead (built-in since Ruby 2.4).
  #   Scheduled for removal after 2027-09-30.
  def clip(lower, upper=nil)
    warn "Comparable#clip is deprecated. Use Comparable#clamp instead. It will be removed after 2027-09-30.", uplevel: 1
    upper ? clamp(lower, upper) : clamp(lower..)
  end

end
