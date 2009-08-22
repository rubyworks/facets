module Kernel

  unless method_defined?(:tap)  # 1.8.7+

    # The tap K-Combinator. This yields self -and- returns self.
    #
    # Note, Ruby 1.9+ does not appear to support the zero arity 
    # instance_eval option.
    #
    def tap(&b)
      if block_given?
        b.arity == 1 ? yield(self) : instance_eval(&b)
      end
      self
    end

    # == Future definition?
    #
    # This is a consideration for a future #tap using Functor:
    #
    #   require 'facets/functor'
    #
    #   def tap(&b)
    #     if block_given?
    #       b.arity == 1 ? yield(self) : instance_eval(&b)
    #       self
    #     else
    #       Functor.new{ |op, *args| self.send(op, *args); self }
    #     end
    #   end
    #
    # It would allow a single call, before returning the original.
    # However there are not very many useful things you can do with
    # that.

  end

end

