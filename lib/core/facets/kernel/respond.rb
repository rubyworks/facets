require 'facets/functor'

module Kernel

  # TODO: Should Kernel#respond be moved to functor gem?

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
  # This method was known as #try until Rails defined #try
  # to be something more akin to #ergo.
  #
  # CREDIT: Chris Wanstrath

  def respond(sym=nil, *args, &blk)
    if sym
      return nil if not respond_to?(sym)
      __send__(sym, *args, &blk)
    else
      Functor.new(&method(:respond).to_proc)
    end
  end

end
