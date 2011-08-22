require 'facets/string/methodize'

class Module

  # Translate a module name to a suitable method name.
  #
  #   module ::EgMethodize
  #     module Eg
  #     end
  #   end
  #
  #   EgMethodize.methodize      #=> "eg_methodize"
  #   EgMethodize::Eg.methodize  #=> "eg_methodize__eg"
  #
  def methodize
    name.methodize
  end

end

