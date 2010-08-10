class Module

  private

  # Aliases a method and undefines the original.
  #
  #   class RenameExample
  #     def foo; "foo"; end
  #     rename_method(:bar, :foo)
  #   end
  # 
  #   example = RenameExample.new
  #   example.bar  #=> 'foo'
  #
  #   expect NoMethodError do
  #     example.foo
  #   end
  #
  # CREDIT: Trans

  def rename_method( to_sym, from_sym )
    raise ArgumentError, "method #{from_sym} does not exist" unless method_defined?( from_sym )
    alias_method( to_sym, from_sym )
    undef_method( from_sym )
  end

  alias_method :rename,   :rename_method

end

