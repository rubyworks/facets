class Module

  private

  # Aliases a method and undefines the original.
  #
  #   rename_method( :to_method, :from_method  )
  #
  #  CREDIT: Trans

  def rename_method( to_sym, from_sym )
    raise ArgumentError, "method #{from_sym} does not exist" unless method_defined?( from_sym )
    alias_method( to_sym, from_sym )
    undef_method( from_sym )
  end

  alias_method :rename,   :rename_method

end

