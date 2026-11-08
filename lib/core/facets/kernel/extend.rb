module Kernel

  extend_method = instance_method(:extend)

  # Removing Ruby's #extend before defining Facets' keeps `ruby -w` from
  # warning that it was redefined; Facets calls it through extend_method.
  # (A module prepended to Kernel would be simpler, but TruffleRuby doesn't
  # apply it to classes that already include Kernel, such as Object.)
  remove_method :extend

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
  # @deprecated The block form is deprecated, so that Facets no longer has
  #   to override Ruby's #extend. Use `obj.extend(Module.new { ... })`
  #   instead. Scheduled for removal after 2027-09-30. Without Facets,
  #   Ruby raises if given only a block, and ignores a block given with
  #   modules.
  #
  # @author Trans
  # @author Marco Otte-Witte (bug fix)
  define_method :extend do |*mods, &blk|
    return extend_method.bind_call(self, *mods) unless blk
    warn "Kernel#extend with a block is deprecated. Use obj.extend(Module.new { ... }) instead. " \
         "It will be removed after 2027-09-30.", uplevel: 1
    extend_method.bind_call(self, *mods) unless mods.empty?
    extend_method.bind_call(self, Module.new(&blk))
  end

end
