require 'facets/functor'

module Kernel

  # Call methods on the eigenclass (i.e. the singleton_class).
  #
  #   name = "Tom"
  #   name.eigen.define_method(:turkey){ self + " Turkey" }
  #   name.turkey #=> "Tom Turkey"
  #
  # One the nice things you can do with #eigen, is define class attributes
  # without having to open a `class << self` block.
  #
  #   c = Class.new do
  #     eigen.attr_accessor :a
  #   end
  #   c.a = 1
  #   c.a #=> 1
  #
  # NOTE: This was once called `#meta`, but meta is such a generic
  # and overly used term that 'eigen' was decided upon as a better
  # choice. You can thank or blame _why for the term, if you like.
  #
  def eigen
    Functor.new do |op,*a,&b|
      (class << self; self; end).class_eval do
        __send__(op,*a,&b)
      end
    end
  end

end

