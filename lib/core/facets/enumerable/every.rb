require 'facets/enumerable/per'

module Enumerable

  # Returns an elemental object. This allows
  # you to map a method on to every element.
  #
  #   r = [1,2,3].every + 3  #=> [4,5,6]
  #
  def every
    per(:map)
  end

  # In place version of #every.
  #
  def every!
    raise NoMethodError unless respond_to?(:map!)
    per(:map!)
  end

  #def every
  #  Functor.new do |op,*args|
  #    map{ |a| a.send(op,*args) }
  #  end
  #end

  #def every!
  #  raise NoMethodError unless respond_to?(:map!)
  #  Functor.new do |op,*args|
  #    map!{ |a| a.send(op,*args) }
  #  end
  #end

end

