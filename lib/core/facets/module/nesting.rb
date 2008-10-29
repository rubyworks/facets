class Module

  # Show a modules nesting in module namespaces.
  #
  #   A::B::C.nesting  #=> [ A, A::B ]
  #
  #  CREDIT: Trans

  def nesting
    n = []
    name.split(/::/).inject(self) do |mod, name|
      c = mod.const_get(name) ; n << c ; c
    end
    return n
  end

end

