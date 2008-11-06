class Module

  # Detect conflicts.
  #
  #   module A
  #     def c; end
  #   end
  #
  #   module B
  #     def c; end
  #   end
  #
  #   A.conflict?(B)  #=> ["c"]
  #
  #
  #   TODO: All instance methods, or just public?
  #
  # CREDIT: Thomas Sawyer, Robert Dober

  def conflict?(other)
    common_ancestor = (ancestors & other.ancestors).first
    c = []
    c += (public_instance_methods(true) & other.public_instance_methods(true))
    c += (private_instance_methods(true) & other.private_instance_methods(true))
    c += (protected_instance_methods(true) & other.protected_instance_methods(true))
    c -= common_ancestor.public_instance_methods(true)
    c -= common_ancestor.private_instance_methods(true)
    c -= common_ancestor.protected_instance_methods(true)
    c.empty? ? false : c
  end

  #def conflict?(other)
  #  c = instance_methods & other.instance_methods
  #  c.empty ? false : c
  #end

  # Like #conflict?, but checks only public methods.
  def public_conflict?(other)
    common_ancestor = (ancestors & other.ancestors).first
    c = public_instance_methods(true) & other.public_instance_methods(true)
    c -= common_ancestor.public_instance_methods(true)
    c.empty? ? false : c
  end

  # Like #conflict?, but checks only private methods.
  def private_conflict?(other)
    common_ancestor = (ancestors & other.ancestors).first
    c = private_instance_methods(true) & other.private_instance_methods(true)
    c -= common_ancestor.private_instance_methods(true)
    c.empty? ? false : c
  end

  # Like #conflict?, but checks only protected methods.
  def protected_conflict?(other)
    common_ancestor = (ancestors & other.ancestors).first
    c = protected_instance_methods(true) & other.protected_instance_methods(true)
    c -= common_ancestor.protected_instance_methods(true)
    c.empty? ? false : c
  end

end

