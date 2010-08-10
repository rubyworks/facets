require 'facets/functor'

module Kernel

  # Invokes the method identified by the symbol +method+, passing it any
  # arguments  and/or the block specified, just like the regular Ruby
  # <tt>Object#send</tt> does.
  #
  # *Unlike* that method however, a +NoMethodError+ exception will *not*
  # be raised and +nil+ will be returned instead, if the receiving object
  # is a +nil+ object or NilClass.
  #
  # For example, without try
  #
  #   @example = Struct.new(:name).new("bob")
  #
  #   @example && @example.name
  #
  # or:
  #
  #   @example? @example.name : nil
  #
  # But with try
  #
  #   @example.try(:name)  #=> "bob"
  #
  # or
  #
  #   @example.try.name  #=> "bob"
  #
  # It also accepts arguments and/or a block, for the method it is trying:
  #
  #   @people.try(:collect){ |p| p.name }
  #
  def try(method=nil, *args, &block)
    if method
      __send__(method, *args, &block)
    else
      self
    end
  end

end


class NilClass

  # See Kernel#try.
  def try(method=nil, *args)
    if method
      nil
    else
      Functor.new{ nil }
    end
  end

end

