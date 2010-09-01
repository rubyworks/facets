require 'facets/opesc'

module Facets

  # Incuding this module in a class or module will automatically load
  # (most) Facets core methods as needed, if they are not already present
  # when called.
  #
  #   class Example
  #     include Facets::AutoExtensions
  #   end
  #
  # THIS IS AN INTERESTING IDEA, BUT CANNOT WORK AS DESIGNED.
  module AutoExtensions

    def method_missing(sym, *a, &b)
      sym = OpEsc.escape(sym)
      begin
        success = require "facets/#{self.class.name.downcase}/#{sym}"
      rescue LoadError
        super(sym, *a, &b)
      end

      if success
        __send__(sym, *a, &b)
      else
        super(sym, *a, &b)
      end
    end

  end

end

