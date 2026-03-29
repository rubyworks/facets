class Module

  # @deprecated Use Module#extend instead.
  def can(*mods)
    warn "Module#can is deprecated. Use Module#extend instead.", uplevel: 1
    extend(*mods)
  end

end
