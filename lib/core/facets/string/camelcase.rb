class String

  # Converts a string to camelcase.
  #
  # By default camelcase convert to UpperCamelCase, If an argument
  # is set to +false+, then camelcase will produce lowerCamelCase.
  #
  # +camelcase+ also converts '/' to '::' which is useful for converting
  # paths to namespaces.
  #
  # Examples
  #   "camel_case".camelcase                    #=> "CamelCase"
  #   "camel/case".camelcase                    #=> "Camel::Case"
  #   "camel_case".camelcase(false)             #=> "camelCase"
  #
  def camelcase(upcase_first_letter=true)
    up = upcase_first_letter
    str = dup
    str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase } if up
    str
  end

end

