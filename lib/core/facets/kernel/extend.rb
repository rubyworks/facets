module Facets

  # Prepended to Kernel, so it wraps Ruby's own #extend instead of
  # replacing it.
  module KernelExtend

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
    # Without a block it is Ruby's own #extend.
    #
    # NOTE: This is one of the few core overrides in Facets.
    #
    # @author Trans
    # @author Marco Otte-Witte (bug fix)
    def extend(*mods, &blk)
      return super unless blk
      super(*mods) unless mods.empty?
      super(Module.new(&blk))
    end

  end

end

Kernel.prepend(Facets::KernelExtend)
