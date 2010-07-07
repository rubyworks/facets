require 'facets/functor'

module Kernel

  # Like #respond_to? but returns the result of the call
  # if it does indeed respond.
  #
  #   class X
  #     def f; "f"; end
  #   end
  #
  #   x = X.new
  #   x.respond(:f)  #=> "f"
  #   x.respond(:g)  #=> nil
  #
  # or
  #
  #   x.respond.f   #=> "f"
  #   x.respond.g   #=> nil
  #
  # This method was known as #try until Rails defined #try
  # to be something more akin to #ergo.
  #
  # CREDIT: Trans, Chris Wanstrath

  def respond(sym=nil, *args, &blk)
    if sym
      return nil if not respond_to?(sym)
      __send__(sym, *args, &blk)
    else
      Functor.new do |op, *a, &b|
        respond(op, *a, &b)
      end
    end
  end

  # DEPRECATE: #respond is enough.
  alias_method :respond_with_value, :respond

end

