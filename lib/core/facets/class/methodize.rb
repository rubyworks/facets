require 'facets/string/methodize'

class Class

  # Translate a class name to a suitable method name.
  #
  #   My::CoolClass.methodize => "my__cool_class"
  #
  def methodize
    name.methodize
  end

end

