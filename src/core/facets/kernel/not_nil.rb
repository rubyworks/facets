module Kernel

  # The opposite of #nil?.
  #
  #   "hello".not_nil?     # -> true
  #   nil.not_nil?         # -> false
  #
  # CREDIT: Gavin Sinclair

  def not_nil?
    ! nil?
  end

  # DEPRECATED: #not_nil? it enough.
  #alias_method :non_nil?, :not_nil?

end

