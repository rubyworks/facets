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
  # CREDIT Trans

  def preextend(aspect)
    aspect.__send__(:include, self)
    extend aspect
  end

end

