class String

  # Converts a string to camelcase.
  #
  # By default camelcase upcases the first character of the string.
  # If +first_letter+ is set to +:lower+ or +true+, then +#camelcase+ will
  # produce lowerCamelCase. If it is set to +:upper+ or +nil+ it will
  # produce UpperCamelCase. If it is set to :inter or +false+ it will
  # leave the first character as given.
  #
  # +#camelcase+ also converts '/' to '::' which is useful for converting
  # paths to namespaces.
  #
  #   "camel_case".camelcase           #=> "CamelCase"
  #   "camel/case".camelcase(:upper)   #=> "Camel::Case"
  #   "Camel_case".camelcase(:lower)   #=> "camelCase"
  #   "camel_case".camelcase(:inter)   #=> "camelCase"
  #   "Camel/case".camelcase(:inter)   #=> "Camel::Case"
  #
  unless method_defined?(:camelcase)
    def camelcase(first_letter=nil)
      case first_letter
      when :lower, true
        lower_camelcase
      when :inter, false
        inter_camelcase
      else
        upper_camelcase
        #str = dup
        #str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
        #str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
        #str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
        #str
      end
    end
  end

  def inter_camelcase
    str = dup
    str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    #str.gsub!(/(\A|\s)([a-z])/){ $1 + $2.upcase }
    str
  end

  def upper_camelcase
    #str = dup
    #str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    #str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    inter_camelcase.gsub(/(\A|\s)([a-z])/){ $1 + $2.upcase }
  end

  def lower_camelcase
    #str = dup
    #str = dup
    #str.gsub!(/\/(.?)/){ "::#{$1.upcase}" }  # NOT SO SURE ABOUT THIS
    #str.gsub!(/(?:_+|-+)([a-z])/){ $1.upcase }
    inter_camelcase.gsub(/(\A|\s)([A-Z])/){ $1 + $2.downcase }
  end

end

