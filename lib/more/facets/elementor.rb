# = Elementor
#
# Provides elementwise functionality.
#
# == Authors
#
# * Thomas Sawyer
# * George Moschovitis
# * Martin DeMello
#
# == Notes
#
# * This could have been impemented with a generic Functor, rather than
#   the specialized Elementor, but for the fact Procs can not yet
#   handle blocks.
# * There used to be a "Cascading Elementor", but that proved idiotic
#   in the face of adding an instance_eval block to #every.
# * Any ideas for a better name for #accumulate? --gmosx
# * The use of every! and it's relation to Enumerator still seems a bit
#   off beat. Should #every always use #map? And another method #each?
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'enumerator'
require 'facets/functor'

module Enumerable

  # Create Elementor.

  def to_elem(meth=nil)
    Elementor.new(self, meth || :map)
  end

  def per
    @__per__ ||= Functor.new do |op|
      Elementor.new(self, op)
    end
  end

  # Returns an elemental object. This allows
  # you to map a method on to every element.
  #
  #   r = [1,2,3].every + 3  #=> [4,5,6]

  def every
    @_every ||= to_elem
  end

  # In place version of #every.

  def every!
    raise NoMethodError unless respond_to?(:map!)
    @_every_inplace ||= to_elem(:map!)
  end

  #def every
  #  @_every ||= Functor.new do |op,*args|
  #    map{ |a| a.send(op,*args) }
  #  end
  #end

  #def every!
  #  raise NoMethodError unless respond_to?(:map!)
  #  @_every_inplace ||= Functor.new do |op,*args|
  #    map!{ |a| a.send(op,*args) }
  #  end
  #end

  # Possible name change for every.
  #
  #   r = [1,2,3].elements + 3  #=> [4,5,6]
  #
  # Certainly reads better.

  alias_method :elements, :every
  alias_method :elements!, :every!

end


# = Elementor
#
# Elementor is a type of Functor. Operations
# applied to it are routed to each element.

class Enumerable::Elementor
  private(*instance_methods.select{|x| x !~ /^__/ })

  def initialize(elem_object, elem_method=nil)
    @elem_object = elem_object
    @elem_method = elem_method || :map
  end

  def instance_delegate
    @elem_object
  end

  def instance_operator
    @elem_method
  end

  def method_missing(sym,*args,&blk)
    @elem_object.__send__(@elem_method){ |x| x.__send__(sym,*args,&blk) }
  end
end


class Enumerable::Enumerator

  # Create Elementor.

  def to_elem(meth=nil)
    Elementor.new(self, meth || :each)
  end

  # Enumerator doesn't support inplace element operations, per se.

  undef_method :every!
  undef_method :elements!
end

