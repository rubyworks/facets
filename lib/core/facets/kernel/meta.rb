require 'facets/functor'

module Kernel

  # TODO: Should Kernel#eigen be moved to a functor gem?

  # Call methods on the eigenclass (i.e. the singleton_class).
  #
  #     name = "Tom"
  #     name.eigen.define_method(:turkey){ self + " Turkey" }
  #     name.turkey #=> "Tom Turkey"
  #
  # One of the nice things you can do with #eigen is define class attributes
  # without having to open a `class << self` block.
  #
  #     c = Class.new do
  #       meta.attr_accessor :a
  #     end
  #     c.a = 1
  #     c.a #=> 1
  #
  def meta
    Functor.new do |op,*a,&b|
      (class << self; self; end).class_eval do
        __send__(op,*a,&b)
      end
    end
  end

  def eigen
    warn "The `eigen' method is deprecated. Please use `meta' instead."
    meta
  end

end
