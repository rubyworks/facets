class Module

  # Show a modules nesting in module namespaces.
  #
  #   module ::EgN
  #     module A
  #       module B
  #         module C
  #         end
  #       end
  #     end
  #   end
  #
  #   EgN::A::B::C.nesting  #=> [ EgN, EgN::A, EgN::A::B ]
  #
  # CREDIT: Trans

  def nesting
    n = []
    name.split(/::/).inject(self) do |mod, name|
      c = mod.const_get(name) ; n << c ; c
    end
    n.pop # we really don't need +self+ too.
    return n
  end

end

