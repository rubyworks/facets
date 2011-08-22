class Module

  # Detect method name clash between modules and/or classes, regardless of
  # method visibility:
  #
  #   module MethodClashExample
  #
  #     module A
  #       def c; end
  #     end
  #
  #     module B
  #       private
  #       def c; end
  #     end
  #
  #     A.method_clash(B)  #=> [:c]
  #
  #   end
  #
  # CREDIT: Thomas Sawyer, Robert Dober
  #
  #--
  # TODO: Should method_clash just be public methods?
  # TODO: Provide an option to select visiblity.
  #++
  def method_clash(other)
    common_ancestor = (ancestors & other.ancestors).first

    s = []
    s += public_instance_methods(true)
    s += private_instance_methods(true)
    s += protected_instance_methods(true)

    o = []
    o += other.public_instance_methods(true)
    o += other.private_instance_methods(true)
    o += other.protected_instance_methods(true)

    c = s & o

    if common_ancestor
      c -= common_ancestor.public_instance_methods(true)
      c -= common_ancestor.private_instance_methods(true)
      c -= common_ancestor.protected_instance_methods(true)
    end

    return c
  end

  # Uses #method_clash to return +true+ or +false+ if there
  # are method name clashes.
  def method_clash?(other) 
    c = method_clash(other) 
    !c.empty?
  end

end

