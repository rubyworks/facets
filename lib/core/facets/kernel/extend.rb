module Kernel

  extend_method = instance_method(:extend)

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
  # NOTE: This is one of the few core overrides in Facets.
  #
  # @author Trans
  # @author Marco Otte-Witte (bug fix)
  define_method :extend do |*mod, &blk|
    extend_method.bind(self).call(*mod) unless mod.empty?
    extend_method.bind(self).call(Module.new(&blk)) if blk
    self
  end

end
