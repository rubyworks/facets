module Kernel

  def case?(*matchers)
    matchers.all?{ |m| m === self }
  end unless method_defined?(:case?)

end

