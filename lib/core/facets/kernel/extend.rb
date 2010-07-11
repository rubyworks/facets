module Kernel

  alias_method :_extend, :extend

  # Extend an object with a module.
  #
  # If a block is given, it will be evaluated into an anonymous
  # module and used to extend the object.
  #
  #   obj = Object.new
  #
  #   obj.extend do
  #     def foo; "foo"; end
  #   end
  #
  #   obj.foo  #=> "foo"
  #
  # NOTE: This is one of the few overrides in Facents.
  def extend(*mod, &blk)
    _extend(*mod) unless mod.empty?
    _extend Module.new(&blk) if blk
    self
  end

end
