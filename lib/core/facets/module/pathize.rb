require 'facets/string/pathize'

class Module

  # Converts a class name to a unix path.
  #
  #   module ::ExamplePathize
  #     module Example
  #     end
  #   end
  #
  #   ExamplePathize.pathize           #=> "example_pathize"
  #   ExamplePathize::Example.pathize  #=> "example_pathize/example"
  #
  def pathize
    name.pathize
  end

end

