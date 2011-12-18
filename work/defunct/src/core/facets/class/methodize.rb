require 'facets/string/methodize'

class Class

  # Translate a class name to a suitable method name.
  #
  #   module ::Example
  #     class MethodizeExample
  #     end
  #   end
  #
  #   Example::MethodizeExample.methodize  #=> "example__methodize_example"
  #
  def methodize
    name.methodize
  end

end

