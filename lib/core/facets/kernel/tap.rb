require 'facets/functor'

module Kernel

  # The tap K-Combinator. This yields self -and- returns self.
  #
  #   'foo.yml'.tap{ |f| YAML.load(f) }  #=> 'foo.yml'
  #
  # Unlike Ruby's definition, this rendition can be used as a higher
  # order message. This form allows a single call before returning
  # the receiver.
  #
  #   YAML.tap.load_file('foo.yml').load_file('bar.yml')
  #
  # IMPORTANT: This is one of few core overrides in Facets.

  def tap #:yield:
    if block_given?
      yield(self)
      self
    else
      Functor.new{ |op,*a,&b| self.send(op, *a, &b); self }
    end
  end

  # Old Definition:
  #
  #   def tap #:yield:
  #     if block_given?
  #       b.arity == 1 ? yield(self) : instance_eval(&b)
  #     end
  #     return self
  #   end
  #

end
