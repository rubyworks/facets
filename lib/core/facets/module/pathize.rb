require 'facets/string/pathize'

class Module

  # Converts a class name to a unix path
  #
  # Examples
  #   CoolClass.pathize       #=> "cool_class"
  #   My::CoolClass.pathize   #=> "my/cool_class"
  #
  def pathize
    name.pathize
    #to_s.
    #  gsub(/::/, '/').
    #  gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    #  gsub(/([a-z\d])([A-Z])/,'\1_\2').
    #  tr("-", "_").
    #  downcase
  end

end

