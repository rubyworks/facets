class Module

  #private  # (we'll leave this one public for AOP-like uses).

  # Creates a new method wrapping the previous of
  # the same name. Reference to the old method
  # is passed into the new definition block
  # as the first parameter.
  #
  #   wrap_method( sym ) { |old_meth, *args|
  #     old_meth.call
  #     ...
  #   }
  #
  # Keep in mind that this can not be used to wrap methods
  # that take a block.
  #
  #   CREDIT: Trans

  def wrap_method( sym, &blk )
    old = instance_method(sym)
    define_method(sym) { |*args| blk.call(old.bind(self), *args) }
  end

  alias_method :wrap, :wrap_method

end

