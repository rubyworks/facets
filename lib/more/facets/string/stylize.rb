class String

  # = String Stylization Extensions
  #
  # The Stylize mixin provides common transformation to strings.
  #
  # This module is automatically mixed into the String class, but
  # the mixin is designed in such a way that it can be mixed into
  # any class that supports the #to_s method.
  #
  # Examples
  #
  #   "super_man".dasherize  #=> "super-man"
  #
  #--
  # TODO: With #pathize, is downcasing really needed? After all paths
  #       can have capitalize letters ;p
  #
  # TODO: With #methodize, is downcasing any but the first letter
  #       really needed? Desipite Matz preference methods can have
  #       capitalized letters.
  #++
  module Stylize

    # Ordinalize turns a number string into an ordinal string
    # used to denote the position in an ordered sequence such
    # as 1st, 2nd, 3rd, 4th.
    #
    #   '1'.ordinalize     # => "1st"
    #   '2'.ordinalize     # => "2nd"
    #   '1002'.ordinalize  # => "1002nd"
    #   '1003'.ordinalize  # => "1003rd"
    #
    def ordinalize
      number_string = to_s
      if number_string =~ /\d{1,2}$/
        number = $1.to_i     
        if (11..13).include?(number.to_i % 100)
          r = "#{number}th"
        else
          r = case number.to_i % 10
            when 1; "#{number}st"
            when 2; "#{number}nd"
            when 3; "#{number}rd"
            else    "#{number}th"
          end
        end
        number_string.sub(/\d{1,2}$/, r)
      else
        number_string
      end
    end

    # Replaces underscores with dashes in the string.
    #
    #   "puni_puni".dasherize  #=> "puni-puni"
    #
    def dasherize
      to_s.gsub(/_/, '-')
    end

    # The reverse of +camelize+. Makes an underscored, lowercase form from
    # the expression in the string.
    #
    # Changes '::' to '/' to convert namespaces to paths.
    #
    #   "ActiveRecord".underscore          #=> "active_record"
    #   "ActiveRecord::Errors".underscore  #=> active_record/errors
    #
    def underscore
      to_s.
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # Converts a module or method name into a unix pathname.
    # This method is geared toward code reflection.
    #
    #   "MyModule::MyClass".pathize    #=> my_module/my_class
    #   "my_module__my_class".pathize  #=> my_module/my_class
    #
    # TODO: Make sure that all scenarios return a valid unix path.
    # TODO: Make sure it is revertible.
    #
    # See also #modulize, #methodize
    def pathize
      to_s.
      gsub(/__/, '/').
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # Converts a module name into a valid method name.
    # This method is geared toward code reflection.
    #
    # Examples
    #   "SuperMan".methodize          #=> "super_man"
    #   "SuperMan::Errors".methodize  #=> "super_man__errors
    #   "MyModule::MyClass".methodize #=> "my_module__my_class"
    #
    # See also #modulize, #pathize
    def methodize
      to_s.
      gsub(/\//, '__').
      gsub(/::/, '__').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # Converts a pathized or methodized string into a valid ruby
    # class or module name. This method is geared toward code
    # reflection.
    #
    #   "camel_case".modulize          #=> "CamelCase"
    #   "camel/case".modulize          #=> "Camel::Case"
    #   "my_module__my_path".modulize  #=> "MyModule::MyPath"
    #
    # See also #methodize, #pathize
    def modulize
      to_s.
      gsub(/__(.?)/){ "::#{$1.upcase}" }.
      gsub(/\/(.?)/){ "::#{$1.upcase}" }.
      gsub(/(?:_+)([a-z])/){ $1.upcase }.
      gsub(/(^|\s+)([a-z])/){ $1 + $2.upcase }
    end

    # Removes the module part from a modularized expression.
    #
    #   "English::Style".demodulize  #=> "Style"
    #   "Style".demodulize           #=> "Style"
    #
    #def demodulize
    #  to_s.gsub(/^.*::/, '')
    #end

    # Include Replace mixin if base class/module supports #replace method.
    def self.included(base)
      if base.instance_methods.include?('replace') or
         base.instance_methods.include?(:replace) # Ruby 1.9
        base.module_eval{ include Replace }
      end
    end

    # In place versions of Stylize methods.
    module Replace
      def ordinalize!    ; replace(ordinalize) ; end
      def pathize!       ; replace(pathize)    ; end
      def methodize!     ; replace(methodize)  ; end
      def modulize!      ; replace(modulize)   ; end
      def dasherize!     ; replace(dasherize)  ; end
      def underscore!    ; replace(underscore) ; end
    end

  end

end

class String #:nodoc:
  include String::Stylize
end

