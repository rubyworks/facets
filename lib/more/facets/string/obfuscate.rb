module English

  # = String Obfuscation
  #
  # The Obfuscate mixin provides a means of applying common
  # scrambling patterns to strings.
  #
  # This module is automatically mixed into the String class, but
  # the mixin is designed in such a way that it can be mixed into
  # any class that supports the #to_s method.
  #
  # Examples
  #
  #   "superman".jumble  #=> "SUpeRmAn"
  #
  module Obfuscate

    # Jumble string.
    #
    #
    def jumble
      j = ''
      to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
      j
    end

    # Dresener Obfuscation.
    #
    # Scramble the inner characters of words leaving the text still readable
    # (research at Cambridge University, code by KurtDresner).
    #
    # For example, the above text may result in:
    #
    #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
    #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)
    #
    # :credit: Kurt Dresener
    def dresner
      to_s.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
    end

    # Include Replace mixin if base class/module supports #replace method.
    def self.included(base)
      if base.instance_methods.include?('replace') or
         base.instance_methods.include?(:replace) # Ruby 1.9
        base.module_eval{ include Replace }
      end
    end

    # TODO: Replace this will dynamic generate of inplace methods.
    #       But only when the base defines #replace (?) Need to
    #       think about this some more.
    module Replace
      def jumble!        ; replace(jumble)        ; end
      def dresner!       ; replace(dresner)       ; end
    end

  end

end

class String #:nodoc:
  include English::Obfuscate
end

