class String

  # Converts a string to camelcase.
  #
  # By default camelcase leaves the first character of the string as given.
  # If +first_letter+ is set to +:lower+ or +false+, then +#camelcase+ will
  # produce lowerCamelCase. If it is set to +:upper+ or +true+ it will
  # produce UpperCamelCase.
  #
  # +#camelcase+ also converts '/' to '::' which is useful for converting
  # paths to namespaces.
  #
  # Examples
  #   "camel_case".camelcase             #=> "camelCase"
  #   "camel/case".camelcase(true)       #=> "Camel::Case"
  #   "Camel_case".camelcase(false)      #=> "camelCase"
  #
  # TODO: Is this the best approach? Should lowerCamelCase be default instead?
  unless method_defined?(:camelcase)
    def camelcase(first_letter=nil)
      case first_letter
      when :upper, true
        upper_camelcase
      when :lower, false
        lower_camelcase
      else
        str = dup
        str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
        str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
        #str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
        str
      end
    end
  end

  def upper_camelcase
    str = dup
    str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
    str
  end

  def lower_camelcase
    str = dup
    str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    str.gsub!(/(\A|\s)([A-Z])/){ $1 + $2.downcase }
    str
  end

end

