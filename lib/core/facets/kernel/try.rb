require 'facets/functor'

module Kernel

  # Invokes the method identified by the symbol +method+, passing it any
  # arguments and/or the block specified. If the receiver is +nil+, it
  # returns +nil+ instead (see NilClass#try below). A method the receiver
  # doesn't have still raises NoMethodError, just like a normal call.
  #
  #   @example.try(:name)              #=> "bob"
  #   @example.try { |o| o.name }     #=> "bob"
  #   @example.try.name               #=> "bob"  (Functor form)
  #   nil.try.name                    #=> nil
  #
  # NOTE: THIS IS NOT ACTIVESUPPORT'S #try. SINCE RAILS 4.0, ACTIVESUPPORT'S
  # #try RETURNS NIL FOR A METHOD THE RECEIVER DOESN'T HAVE, SO A TYPO LIKE
  # user.try(:nmae) QUIETLY BECOMES NIL AND HIDES THE BUG. FACETS KEEPS #try
  # STRICT AND PUTS THE LENIENT BEHAVIOR IN #try!, WHERE IT BELONGS: IN RUBY,
  # THE BANG MARKS THE MORE DANGEROUS VERSION OF A METHOD, AND SWALLOWING A
  # MISSING METHOD IS THE DANGEROUS ONE. RAILS HAS THE TWO BACKWARD.
  #
  def try(method=nil, *args, &block)
    if method
      __send__(method, *args, &block)
    elsif block_given?
      yield self
    else
      self
    end
  end

  # Like #try, but also returns +nil+ if the receiver doesn't respond to
  # +method+ (or it is private), instead of raising NoMethodError.
  #
  #   @example.try!(:name)             #=> "bob"
  #   @example.try!(:nmae)             #=> nil
  #
  # NOTE: THIS IS THE OPPOSITE OF ACTIVESUPPORT'S #try!, WHICH RAISES. THE
  # BANG IS HERE BECAUSE QUIETLY IGNORING A MISSING METHOD IS THE DANGEROUS
  # BEHAVIOR; SEE #try ABOVE.
  #
  def try!(method=nil, *args, &block)
    if method
      public_send(method, *args, &block) if respond_to?(method)
    elsif block_given?
      yield self
    else
      self
    end
  end

end

class NilClass

  # See Kernel#try.
  def try(method=nil, *args, &block)
    if method
      nil
    elsif block_given?
      nil
    else
      Functor.new { nil }
    end
  end

  # See Kernel#try!.
  def try!(method=nil, *args, &block)
    if method
      nil
    elsif block_given?
      nil
    else
      Functor.new { nil }
    end
  end

end
