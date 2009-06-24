require 'facets/functor'

module Kernel

  # Fluent notation for accessing private methods.
  # This is a meta-progrmmers tool, and not meant
  # for general use.
  #
  #   class X
  #     attr :a
  #     private :a
  #     def initialize
  #       @a = 1
  #     end
  #   end
  #
  #   x = X.new
  #   p x.pry.a  #=> 1
  #   p x.a      #=> Error
  #
  # TODO: Add support for blocks in Ruby 1.9
  #
  # CREDIT: trans

  def pry
    @__pry__ ||= Functor.new do |s, *a|
      instance_eval{ send(s, *a) }
    end
  end

end

