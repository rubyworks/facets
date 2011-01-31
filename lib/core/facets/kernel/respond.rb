require 'facets/functor'

module Kernel

  # Like #respond_to? but returns the result of the call
  # if it does indeed respond.
  #
  #   class RespondExample
  #     def f; "f"; end
  #   end
  #
  #   x = RespondExample.new
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
      ## TODO: use after 1.8.6 not supported anymore
      ##Functor.new do |op, *a, &b|
      ##  respond(op, *a, &b)
      ##end
      Functor.new(&method(:respond).to_proc)
    end
  end

  # DEPRECATED: #respond is enough.
  #alias_method :respond_with_value, :respond

end
