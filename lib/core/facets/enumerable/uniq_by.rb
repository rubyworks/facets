module Enumerable

  # @deprecated Use Enumerable#uniq with a block instead (Ruby 1.9.2+).
  #   Scheduled for removal after 2027-09-30.
  def uniq_by(&block)
    warn "Enumerable#uniq_by is deprecated. Use Enumerable#uniq(&block) instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    uniq(&block)
  end

end
