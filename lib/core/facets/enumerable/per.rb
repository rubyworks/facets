require 'facets/functor'

module Enumerable

  # Per element meta-functor.
  #
  #   [1,2,3].per + 3             #=> [4,5,6]
  #   [1,2,3].per(:map) + 3       #=> [4,5,6]
  #   [1,2,3].per(:select) > 1    #=> [2,3]
  #
  #   [1,2,3].per.map + 3       #=> [4,5,6]
  #   [1,2,3].per.select > 1    #=> [2,3]
  #
  def per(enum_method=nil, *enum_args)
    if enum_method
      Permeator.new(self, enum_method, *enum_args)
      #Functor.new do |op, *args|
      #  __send__(enum_method, *enum_args){ |x| x.__send__(op, *args) } #, &blk) }
      #end
    else
      @__per__ ||= Functor.new do |enum_method, *enum_args|
        Permeator.new(self, enum_method, *enum_args)
        #Functor.new do |op, *args|
        #  __send__(enum_method, *enum_args){ |x| x.__send__(op, *args) } #, &blk) }
        #end
      end
    end
  end

  # Permeator is a Functor for operating over each element of an Enumearble.
  # (Note: This used to be called an Elementor.)
  #
  # TODO: With Ruby 1.9+ this isn't required, as it can be replaced by a generic Functor,
  # becuase then lambda definitions can pass blocks.
  #
  class Permeator #:nodoc:
    private(*instance_methods.select{|x| x !~ /^__/ })

    def initialize(elem_object, elem_method=nil, *elem_args)
      @elem_object = elem_object
      @elem_method = elem_method || :map
      @elem_args   = elem_args
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

end

=begin
class Enumerable::Enumerator

  # Create Elementor.

  def to_elem(meth=nil)
    Elementor.new(self, meth || :each)
  end

  # Enumerator doesn't support inplace element operations, per se.

  undef_method :every!
  undef_method :elements!
end
=end

