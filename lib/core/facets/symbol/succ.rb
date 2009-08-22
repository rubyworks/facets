class Symbol

  unless method_defined?(:succ)  # 1.9+ TODO: is this right?

    # Successor method for symobol. This simply converts
    # the symbol to a string uses String#succ and then
    # converts it back to a symbol.
    #
    #   :a.succ => :b
    #
    # TODO: Make this work more like a simple character dial?

    def succ
      self.to_s.succ.intern
    end

  end

end
