class Binding

  # This is already defined by Rubinius:
  #   Kernel.eval('Rubinius::VariableScope.current.self', self)
  unless method_defined?(:self)

    # Returns self of the binding's context.
    def self
      eval('self')
    end

  end

end

