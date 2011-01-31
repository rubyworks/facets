require 'facets/binding/eval'

class Binding

  # Returns the local variables defined in the binding context:
  #
  #   a = 1
  #   b = 2
  #
  #   binding.local_variables  #=> [:a, :b]
  #
  def local_variables()
    eval("local_variables")
  end

end

