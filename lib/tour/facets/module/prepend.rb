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
  #   PreX.prepend(PreU)
  #
  #   PreX.x  # => "{x}"
  #
  # CREDIT Trans

  def prepend(aspect)
    aspect.__send__(:include, self)
    extend aspect
  end

end

