class Module

  # Prepend an +aspect+ module to a module.
  # This only works at the module level.
  #
  #   module ::PreX
  #     def x; "x"; end
  #   end
  #
  #   module ::PreU
  #     def x; '{' + super + '}'; end
  #   end
  #
  #   PreX.preextend(PreU)
  #
  #   PreX.x  # => "{x}"
  #
  # NOTE: This is not a common core extension and is not loaded
  # automatically when using <code>require 'facets'</code>.
  #
  # CREDIT Trans
  #
  # @uncommon
  #   require 'facets/module/preextend'
  #
  def preextend(aspect)
    aspect.__send__(:include, self)
    extend aspect
  end

end

