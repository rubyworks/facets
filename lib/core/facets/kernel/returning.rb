module Kernel

  # @deprecated Use Kernel#tap instead (built-in since Ruby 1.9).
  #   Scheduled for removal after 2027-09-30.
  #
  def returning(obj=self)
    warn "Kernel#returning is deprecated. Use Kernel#tap instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    yield obj
    obj
  end

end
