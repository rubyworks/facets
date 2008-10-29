require 'facets/string/methodize'

class Module

  # Translate a module name to a suitable method name.
  #
  #   My::CoolClass.methodize => "my__cool_class"
  #
  def methodize
    name.methodize
  end

end

