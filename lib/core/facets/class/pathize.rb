require 'facets/string/pathize'

class Class

  # Converts a class name to a unix path.
  #
  #   My::CoolClass.pathize  #=> "my/cool_class"
  #
  def pathize
    name.pathize
  end

end

