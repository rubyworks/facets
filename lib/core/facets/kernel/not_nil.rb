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

  alias_method :non_nil?, :not_nil?

end

