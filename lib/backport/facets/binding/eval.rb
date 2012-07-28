class Binding

  unless method_defined?(:eval) # 1.8.7+

    # Evaluate a Ruby source code string (or block) in the binding context.

    def eval(str, *file_and_line)
      Kernel.eval(str, self, *file_and_line)
    end

  end

end

