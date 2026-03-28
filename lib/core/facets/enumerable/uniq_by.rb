module Enumerable

  # @deprecated Use Enumerable#uniq with a block instead (Ruby 1.9.2+).
  def uniq_by(&block)
    warn "Enumerable#uniq_by is deprecated. Use Enumerable#uniq(&block) instead.", uplevel: 1
    uniq(&block)
  end

end
