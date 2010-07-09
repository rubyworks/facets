require 'facets/string/pathize'

class Class

  # Converts a class name to a unix path.
  #
  #   module ::Example
  #     class PathizeExample
  #     end
  #   end
  #
  #   Example::PathizeExample.pathize  #=> "example/pathize_example"
  #
  def pathize
    name.pathize
  end

end

