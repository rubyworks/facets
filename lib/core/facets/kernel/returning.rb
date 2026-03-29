module Kernel

  # @deprecated Use Kernel#tap instead (built-in since Ruby 1.9).
  #
  def returning(obj=self)
    warn "Kernel#returning is deprecated. Use Kernel#tap instead.", uplevel: 1
    yield obj
    obj
  end

end
