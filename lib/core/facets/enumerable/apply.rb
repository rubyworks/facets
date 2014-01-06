#require 'facets/functor'
require 'facets/enumerable/per'

module Enumerable

  # Returns an elemental object. This allows
  # you to map a method on to every element.
  #
  #   r = [1,2,3].apply.+ 
  #   r  #=> 6
  #
  def apply
    #Functor.new do |sym, *args, &blk|
    #  inject{ |r, e| r.__send__(sym, e, *args, &blk) }
    #end
    per(:inject)
  end

end

