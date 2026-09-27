class Module

  # @deprecated Use Module#extend instead.
  #   Scheduled for removal after 2027-09-30.
  def can(*mods)
    warn "Module#can is deprecated. Use Module#extend instead. It will be removed after 2027-09-30.", uplevel: 1
    extend(*mods)
  end

end
